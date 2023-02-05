push!(LOAD_PATH,"../src/")
using Documenter, EquiBaryInterp

Documenter.HTML(
    mathengine = MathJax3(Dict(
        :loader => Dict("load" => ["[tex]/physics"]),
        :tex => Dict(
            "inlineMath" => [["\$","\$"], ["\\(","\\)"]],
            "tags" => "ams",
            "packages" => ["base", "ams", "autoload", "physics"],
        ),
    )),
)

makedocs(
    sitename="EquiBaryInterp.jl",
    modules=[EquiBaryInterp],
    pages = [
        "Home" => "index.md",
        "Manual" => "methods.md",
    ],
)

deploydocs(
    repo = "github.com/lxvm/EquiBaryInterp.jl.git",
)