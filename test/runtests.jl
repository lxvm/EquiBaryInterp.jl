using Test
using EquiBaryInterp: BaryPoly, LocalEquiBaryInterp, barycentric_weights, equi_bary_weights

@testset "EquiBaryInterp" begin
    @testset "BaryPoly" for degree=(8, 10, 20) # larger degrees begin to overflow
        # check that the numerical weights match the analytic formula
        r = 0:degree # ranges are dispatched to analytic formula
        x = collect(r) # Vectors are used to compute numerical weights
        @test factorial(degree)*barycentric_weights(x) ≈ barycentric_weights(r)

        # Check that BaryPoly runs on example functions
        for f in (sin∘exp, cis∘inv∘exp) # both real and complex functions
            θ = range(0, 1, length=degree) # equispace nodes
            yθ = f.(θ) # data
            bθ = BaryPoly(θ, yθ)
            @test bθ(0.1111) ≈ f(0.1111) atol=1e-3

            c = reverse(cospi.(θ)) # Chebyshev nodes
            yc =  f.(c) # data
            bc = BaryPoly(c, yc) #
            @test bc(0.1111) ≈ f(0.1111) atol=1e-3
            
            # out of sample
            @test_throws ArgumentError bc(2.0)
        end
    end

    @testset "LocalEquiBaryInterp" begin
        # Check that the equispace interpolant refuses non-equispace,
        # non-increasing data
        @test_throws InexactError LocalEquiBaryInterp(rand(15), rand(15))
        @test_throws ArgumentError LocalEquiBaryInterp(1:-1:15, rand(15))

        nsamp=2001
        for degree in (8, 10, 20)
            # Check that BaryPoly runs on example functions
            for f in (sin∘exp, cis∘inv∘exp) # both real and complex functions
                θ = range(0, 1, length=nsamp) # equispace nodes
                yθ = f.(θ) # data
                bθ = LocalEquiBaryInterp(θ, yθ, degree)
                @test bθ(0.1111) ≈ f(0.1111) atol=1e-5

                @test_throws ArgumentError bθ(2.0) # out of sample

                c = reverse(cospi.(θ)) # Chebyshev nodes / non-equispace data
                yc =  f.(c) # data
                @test_throws InexactError LocalEquiBaryInterp(c, yc, degree)
            end
        end
    end
end