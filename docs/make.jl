using SeisMakie
using Documenter

DocMeta.setdocmeta!(SeisMakie, :DocTestSetup, :(using SeisMakie); recursive=true)

makedocs(;
    modules=[SeisMakie],
    authors="Firas <firas_alchalabi@hotmail.com> and contributors",
    repo="https://github.com/firasalchalabi/SeisMakie.jl/blob/{commit}{path}#{line}",
    sitename="SeisMakie.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://firasalchalabi.github.io/SeisMakie.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/firasalchalabi/SeisMakie.jl",
    devbranch="main",
)
