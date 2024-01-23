module SeisMakie

    # Write your package code here.
    using Makie

    include("WiggleRecipe.jl")
    include("ImageRecipe.jl")

    export wiggleplot

end
