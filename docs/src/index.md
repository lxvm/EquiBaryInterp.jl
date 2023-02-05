# EquiBaryInterp.jl

This package allows for local barycentric Lagrange interpolation on equispace
data, which avoids the ill-conditioning of global polynomial interpolation on
large equispace datasets. [^1]

[^1] [Berrut and Trefethen (2004) SIAM review](https://doi.org/10.1137/S0036144502417715)