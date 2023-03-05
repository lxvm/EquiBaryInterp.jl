# EquiBaryInterp.jl

[Documentation](https://lxvm.github.io/EquiBaryInterp.jl/dev/)

This package provides local [barycentric Lagrange
interpolation](https://en.wikipedia.org/wiki/Lagrange_polynomial#Barycentric_form)
for data on equispace grids. This is useful to provide a well-conditioned and
fast-to-evaluate low-degree polynomial interpolant of equispaced data.

## Usage

To construct an interpolant for some arbitrary data, the interface is like this
```julia
julia> using EquiBaryIntep

julia> nodes = range(0, 1, length=1000)

julia> data  = rand(length(nodes))

julia> p = LocalEquiBaryInterp(nodes, data, degree=8)
```
This returns an interpolant `p` that can be evaluated at any point in the span
of the nodes using the functor interface, e.g. `p(rand())`.

## Algorithm

The barycentric interpolation kernel used by `LocalEquiBaryInterp` is based on
- [Berrut and Trefethen, "Barycentric Lagrange Interpolation", SIAM Review, 46,
  3, 501-507, 2004](https://epubs.siam.org/doi/10.1137/S0036144502417715)

## Author and Copyright

EquiBaryInterp.jl was written by [Lorenzo Van Muñoz](https://web.mit.edu/lxvm/www/),
and is free/open-source software under the MIT license.

## Related packages
- [BarycentricInterpolation.jl](https://github.com/dawbarton/BarycentricInterpolation.jl)
- [Interpolations.jl](https://github.com/JuliaMath/Interpolations.jl)
