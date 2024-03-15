var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = SeisMakie","category":"page"},{"location":"#SeisMakie","page":"Home","title":"SeisMakie","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for SeisMakie.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [SeisMakie]","category":"page"},{"location":"#SeisMakie.SeisDifference-Tuple{Any, Any}","page":"Home","title":"SeisMakie.SeisDifference","text":"SeisDifference(d1, d2; <keyword arguments>)\n\nPlot time-space, 2D seismic data d1, d2, and their difference (d1 - d2) with color, wiggles or overlay. The plots are arranged horizontally by default.\n\nArguments:\n\nd1::Matrix{<:AbstractFloat}: the measured seismic traces. Number of columns corresponds to number                                of traces whereas number of rows corresponds to the number of times                                amplitude was measured for each trace\nd2::Matrix{<:AbstractFloat}: same description as d1.\n\nKeyword Arguments:\n\nfig=nothing: the figure we want to plot on. If not supplied, one will be created and returned.\ngx::Vector{<:Real}=nothing: the real coordinates of the seismometers corresponding to the traces in d\nox=0: first point of x-axis.\ndx=1: increment of x-axis.\noy=0: first point of y-axis.\ndy=1: increment of y-axis.\npclip=98: percentile for determining clip.\nvmin=nothing: minimum value used in colormapping data.\nvmax=nothing: maximum value used in colormapping data.\nwiggle_fill_color=:black: color for filling the positive wiggles.\nwiggle_line_color=:black: color for wiggles' lines.\nwiggle_trace_increment=1: increment for wiggle traces.\nxcur=1.2: wiggle excursion in traces corresponding to clip.\ncmap=:viridis: the colormap to be used for color and overlay plots.\nstyle: determines the type of plot. Can be either \"wiggle\"/\"wiggles\", \"color\", \"overlay\".\nhorizontal=true: if set to false, d1, d2, and their difference are arranged vertically.\n\nReturn the figure and 3 axes corresponding to d1, d2, d1-d2.\n\nExample\n\njulia> d1 = SeisLinearEvents(); d2 = SeisLinearEvents();\njulia> f, ax1, ax2, ax_diff = SeisDifference(d1, d2);\n\nAuthor: Firas Al Chalabi (2024)\n\n\n\n\n\n","category":"method"},{"location":"#SeisMakie.SeisPlotAmplitude-Tuple{Matrix{<:Real}}","page":"Home","title":"SeisMakie.SeisPlotAmplitude","text":"SeisPlotAmplitude(d,fmax,dy ; <keyword arguments>)\n\nPlot amplitude-frequency 2D seismic data d\n\nArguments\n\nd::Array{Real,2}: 2D data to plot.\n\nKeyword arguments\n\nfig=nothing: the figure we want to plot on. If not supplied, one will be created and returned.\nax=nothing: the axis we want to plot on. If not supplied, one will be created and returned.\nfmax=100: maximum frequency.\ndy=0.004: time sample interval.\nnormalize=false: whether or not to normalize the data\ncolor=:red: color of the plot.\nlabel=\"\": plot label to be included in legend\n\nExample\n\njulia> d = SeisLinearEvents();\njulia> f, ax = SeisPlotAmplitude(d,100,0.004);\n\nAuthor: Firas Al Chalabi (2024)\n\n\n\n\n\n","category":"method"},{"location":"#SeisMakie.SeisPlotFK-Tuple{Any}","page":"Home","title":"SeisMakie.SeisPlotFK","text":"SeisPlotFK(d; <keyword arguments>)\n\nPlot frequency-wavenumber 2D seismic data d.\n\nArguments\n\nd::Matrix{<:AbstractFloat}: 2D data to plot.\n\nKeyword arguments:\n\nfig=nothing: the figure we want to plot on. If not supplied, one will be created and returned.\npclip=99.9: percentile for determining clip.\nvmin=nothing: minimum value used in colormapping data.\nvmax=nothing: maximum value used in colormapping data.\nfmax=100: maximum frequency for \"FK\" or \"Amplitude\" plot.\ndx=1: increment of x-axis.\ndy=1: increment of y-axis.\ncmap=:PuOr: colormap\n\nReturn the figure and axis corresponding to d.\n\nExample\n\njulia> d = SeisLinearEvents(); \njulia> f, ax = SeisPlotFK(d);\n\nAuthor: Firas Al Chalabi (2024)\n\n\n\n\n\n","category":"method"},{"location":"#SeisMakie.SeisPlotTX-Tuple{Any}","page":"Home","title":"SeisMakie.SeisPlotTX","text":"SeisPlotTX(d; <keyword arguments>)\n\nPlot time-space, 2D seismic data d with image, wiggles or overlay.\n\nArguments:\n\nd::Matrix{<:AbstractFloat}: the measured seismic traces. Number of columns corresponds to number                               of traces whereas number of rows corresponds to the number of times                               amplitude was measured for each trace\n\nKeyword Arguments:\n\nfig=nothing: the figure we want to plot on. If not supplied, one will be created and returned.\ngx::Vector{<:Real}=nothing: the real coordinates of the seismometers corresponding to the traces in d. Only                                supported with style=\"wiggles\"\nox=0: first point of x-axis.\ndx=1: increment of x-axis.\noy=0: first point of y-axis.\ndy=1: increment of y-axis.\npclip=98: percentile for determining clip.\nvmin=nothing: minimum value used in colormapping data.\nvmax=nothing: maximum value used in colormapping data.\nwiggle_fill_color=:black: color for filling the positive wiggles.\nwiggle_line_color=:black: color for wiggles' lines.\nwiggle_trace_increment=1: increment for wiggle traces.\nxcur=1.2: wiggle excursion in traces corresponding to clip.\ncmap=:seismic: the colormap to be used for image and overlay plots.\nstyle: determines the type of plot. Can be either \"wiggle\"/\"wiggles\", \"image\", \"overlay\".\n\nReturn the figure and axis corresponding to d.\n\nExample\n\njulia> d = SeisLinearEvents();\njulia> f, ax = SeisPlotTX(d);\n\nAuthor: Firas Al Chalabi (2024)\n\n\n\n\n\n","category":"method"},{"location":"#SeisMakie.seisamplitude-Tuple","page":"Home","title":"SeisMakie.seisamplitude","text":"seisamplitude(d; <keyword arguments>)\nseisamplitude!(ax, d; <keyword arguments>)\n\nPlot amplitude-frequency 2D seismic data d.\n\nArguments\n\nd::Array{Real,2}: 2D data to plot.\n\nKeyword arguments\n\nfmax=100: maximum frequency.\ndy=0.004: time sample interval.\nnormalize=false: whether or not to normalize the data\ncolor=:black: color of the plot.\nlabel=\"\": plot label to be included in legend\n\nExamples\n\njulia> d = SeisLinearEvents();\njulia> f, ax, amp = seisamplitude(d)\n\njulia> d = SeisLinearEvents(); f = Figure(); ax = Axis(f)\njulia> amp = seisamplitude!(ax, d)\n\nAuthor: Firas Al Chalabi (2024) Credits: Aaron Stanton (2015)\n\nMost of the code in this file is taken from SeisPlot.jl written by Aaron Stanton.\n\n\n\n\n\n","category":"method"},{"location":"#SeisMakie.seisfk-Tuple","page":"Home","title":"SeisMakie.seisfk","text":"seisfk(d; <keyword arguments>)\nseisfk!(ax, d; <keyword arguments>)\n\nPlot frequency-wavenumber 2D seismic data d.\n\nArguments\n\nd::Matrix{<:AbstractFloat}: 2D data to plot.\n\nKeyword arguments:\n\nfig=nothing: the figure we want to plot on. If not supplied, one will be created and returned.\npclip=99.9: percentile for determining clip.\nvmin=nothing: minimum value used in colormapping data.\nvmax=nothing: maximum value used in colormapping data.\nfmax=100: maximum frequency for \"FK\" or \"Amplitude\" plot.\ndx=1: increment of x-axis.\ndy=1: increment of y-axis.\ncmap=:PuOr: colormap\n\nReturn the figure and axis corresponding to d.\n\nExamples\n\njulia> d = SeisLinearEvents();\njulia> f, ax, fk = seisfk(d)\n\njulia> d = SeisLinearEvents(); f = Figure(); ax = Axis(f)\njulia> fk = seisfk!(ax, d)\n\nAuthor: Firas Al Chalabi (2024) Credits: Aaron Stanton (2015)\n\nMost of the code in this file is taken from SeisPlot.jl written by Aaron Stanton.\n\n\n\n\n\n","category":"method"},{"location":"#SeisMakie.seisimage-Tuple","page":"Home","title":"SeisMakie.seisimage","text":"seisimage(d; <keyword arguments>);\nseisimage!(ax, d; <keyword arguments>);\n\nRecipe to plot time-space, color plot of 2D seismic data d.\n\nArguments:\n\nd::Matrix{<:AbstractFloat}: 2D seismic data to be plotted.\n\nKeyword Arguments:\n\nox=0: first point of x-axis.\ndx=1: increment of x-axis.\noy=0: first point of y-axis.\ndy=1: increment of y-axis.\npclip=98: percentile for determining clip.\nvmin=nothing: minimum value used in colormapping data.\nvmax=nothing: maximum value used in colormapping data.\ncmap=:seismic: the colormap to be used.\n\nExamples\n\njulia> d = SeisLinearEvents();\njulia> f, ax, img = seisimage(d)\n\njulia> d = SeisLinearEvents(); f = Figure(); ax = Axis(f)\njulia> img = seisimage!(ax, d)\n\nAuthor: Firas Al Chalabi (2024) Credits: Aaron Stanton (2015)\n\nMost of the code in this file is taken from SeisPlot.jl written by Aaron Stanton.\n\n\n\n\n\n","category":"method"},{"location":"#SeisMakie.seisoverlay-Tuple","page":"Home","title":"SeisMakie.seisoverlay","text":"seisoverlay(d; <keyword arguments>)\nseisoverlay!(ax, d; <keyword arguments>)\n\nRecipe to plot time-space, overlay plot of 2D seismic data d.\n\nArguments:\n\nd::Matrix{<:AbstractFloat}: 2D seismic data to be plotted.\n\nKeyword Arguments:\n\nox=0: first point of x-axis.\ndx=1: increment of x-axis.\noy=0: first point of y-axis.\ndy=1: increment of y-axis.\npclip=98: percentile for determining clip.\nvmin=nothing: minimum value used in colormapping data.\nvmax=nothing: maximum value used in colormapping data.\nwiggle_fill_color=:black: color for filling the positive wiggles.\nwiggle_line_color=:black: color for wiggles' lines.\nwiggle_trace_increment=1: increment for wiggle traces.\nxcur=1.2: wiggle excursion in traces corresponding to clip.\ncmap=:seismic: the colormap to be used.\n\nExamples\n\njulia> d = SeisLinearEvents();\njulia> f, ax, ov = seisoverlay(d)\n\njulia> d = SeisLinearEvents(); f = Figure(); ax = Axis(f)\njulia> ov = seisoverlay!(ax, d)\n\n\n\n\n\n","category":"method"},{"location":"#SeisMakie.seiswiggle-Tuple","page":"Home","title":"SeisMakie.seiswiggle","text":"seiswiggle(d; <keyword arguments>)\nseiswiggle!(ax, d; <keyword arguments>)\n\nRecipe to plot time-space, wiggle plot of 2D seismic data d.\n\nArguments:\n\nd::Matrix{<:AbstractFloat}: the measured seismic traces. Number of columns corresponds to number                               of traces whereas number of rows corresponds to the number of times                               amplitude was measured for each trace\n\nKeyword Arguments:\n\ngx::Vector{<:Real}=nothing: the real coordinates of the seismometers corresponding to the traces in d\nox=0: first point of x-axis.\ndx=1: increment of x-axis.\noy=0: first point of y-axis.\ndy=1: increment of y-axis.\nwiggle_fill_color=:black: color for filling the positive wiggles.\nwiggle_line_color=:black: color for wiggles' lines.\nwiggle_trace_increment=1: increment for wiggle traces.\nxcur=1.2: wiggle excursion in traces.\n\nExamples\n\njulia> d = SeisLinearEvents();\njulia> f, ax, wp = seiswiggle(d)\n\njulia> d = SeisLinearEvents(); f = Figure(); ax = Axis(f)\njulia> wp = seiswiggle!(ax, d)\n\nAuthor: Firas Al Chalabi (2024) Credits: Aaron Stanton (2015) \n\nThe code in this file was inspired by some of Aaron Stanton's in SeisPlot.jl.\n\n\n\n\n\n","category":"method"}]
}
