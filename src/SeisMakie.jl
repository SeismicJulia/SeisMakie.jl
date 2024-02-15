
module SeisMakie

    # Write your package code here.
    using Makie
    using Statistics
    using FFTW

    include("Recipes/SeisWiggleRecipe.jl")
    include("Recipes/SeisColorRecipe.jl")
    include("Recipes/SeisOverlayRecipe.jl")

    include("SeisWiggle.jl")
    include("SeisOverlay.jl")
    include("SeisColor.jl")
    include("SeisDifference.jl")


    include("SeisPlotFK.jl")
    include("SeisPlotTX.jl")

    include("Util.jl")

    export SeisWiggle
    export SeisColor
    export SeisOverlay

    export SeisDifference
    export SeisPlotTX
    export SeisPlotFK

end
