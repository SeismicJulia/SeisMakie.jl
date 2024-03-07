module SeisMakie

    using Makie
    using Statistics
    using FFTW

    include("Recipes/SeisWiggleRecipe.jl")
    include("Recipes/SeisImageRecipe.jl")
    include("Recipes/SeisOverlayRecipe.jl")
    include("Recipes/SeisAmplitudeRecipe.jl")
    include("Recipes/SeisFKRecipe.jl")

    include("SeisDifference.jl")

    include("SeisPlotFK.jl")
    include("SeisPlotTX.jl")
    include("SeisPlotAmplitude.jl")

    include("Util.jl")

    export seisamplitude
    export seisamplitude!
    export seisfk
    export seisfk!
    export seisimage
    export seisimage!
    export seisoverlay
    export seisoverlay!
    export seiswiggle
    export seiswiggle!

    export SeisDifference
    export SeisPlotTX
    export SeisPlotFK
    export SeisPlotAmplitude

end
