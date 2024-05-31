module SeisMakie

    using Makie
    using Statistics
    using FFTW

    include("Recipes/SeisWiggleRecipe.jl")
    include("Recipes/SeisImageRecipe.jl")
    include("Recipes/SeisOverlayRecipe.jl")
    include("Recipes/SeisAmplitudeRecipe.jl")
    include("Recipes/SeisFKRecipe.jl")

    include("seisDifference.jl")

    include("seisPlotFK.jl")
    include("seisPlotTX.jl")
    include("seisPlotAmplitude.jl")

    include("makeAnimation.jl")

    include("Util.jl")

    export seisamplitudeplot
    export seisamplitudeplot!
    export seisfkplot
    export seisfkplot!
    export seisimageplot
    export seisimageplot!
    export seisoverlayplot
    export seisoverlayplot!
    export seiswiggleplot
    export seiswiggleplot!

    export seisDifference
    export seisPlotTX
    export seisPlotFK
    export seisPlotAmplitude

    export makeAnimation

end
