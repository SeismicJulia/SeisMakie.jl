"""
    seiswiggle(d; <keyword arguments>)
    seiswiggle!(ax, d; <keyword arguments>)

Recipe to plot time-space, wiggle plot of 2D seismic data `d`.

# Arguments:
- `d::Matrix{<:AbstractFloat}`: the measured seismic traces. Number of columns corresponds to number
                                of traces whereas number of rows corresponds to the number of times
                                amplitude was measured for each trace

# Keyword Arguments:
- `gx::Vector{<:Real}=nothing`: the real coordinates of the seismometers corresponding to the traces in d
- `ox=0`: first point of x-axis.
- `dx=1`: increment of x-axis.
- `oy=0`: first point of y-axis.
- `dy=1`: increment of y-axis.

- `wiggle_fill_color=:black`: color for filling the positive wiggles.
- `wiggle_line_color=:black`: color for wiggles' lines.
- `wiggle_trace_increment=1`: increment for wiggle traces.
- `xcur=1.2`: wiggle excursion in traces.

# Examples
```julia
julia> d = SeisLinearEvents();
julia> f, ax, wp = seiswiggle(d)
```
```julia
julia> d = SeisLinearEvents(); f = Figure(); ax = Axis(f)
julia> wp = seiswiggle!(ax, d)
```

**Note: animations only work with this recipe if you update the observable `d` 
with a matrix of the same size.**

Author: Firas Al Chalabi (2024)
Credits: Aaron Stanton (2015) 
- The code in this file was inspired by some of Aaron Stanton's in SeisPlot.jl.
"""
@recipe(SeisWigglePlot, d) do scene
    Attributes(
        wiggle_line_color = :black,
        wiggle_fill_color = :black,

        trace_width = 0.7,

        gx = nothing,
        ox = 0,
        dx = 1,

        oy = 0,
        dy = 1,

        xcur = 1.2,
        wiggle_trace_increment = 1,

        fillbands = true,
    )
end

function Makie.plot!(wp::SeisWigglePlot{<:Tuple{AbstractMatrix{<:Real}}})

    d = wp.d
    gx = wp.gx

    ox = wp.ox[]
    dx = wp.dx[]

    oy = wp.oy[]
    dy = wp.dy[]

    xcur = wp.xcur[]
    wiggle_trace_increment = wp.wiggle_trace_increment[]

    if isnothing(gx[])
        gx[] = [ox+(i-1)*dx for i in 1:size(d[], 2)]
    end

    traces = []
    positive_traces = []
    zero_lines = []

    function update_plot(d, gx)

        dgx = minimum([gx[i]-gx[i-1] for i in 2:length(gx)])
        max_perturb = maximum(abs, d)
        times = oy:dy:(dy*(size(d, 1)-1)+oy)
        z = zeros(length(size(d, 1)))
        scale = wiggle_trace_increment*dgx*xcur/max_perturb

        st = gx[1]
        j = 1
        for i = 1:length(gx)
            while gx[i] >= st+wiggle_trace_increment*dgx
                st += wiggle_trace_increment*dgx
            end
    
            if gx[i] >= st && gx[i] < st+wiggle_trace_increment*dgx
                trace = Point2.(gx[i] .+ (scale .* d[:, i]), times)
                pos_trace = Point2.(gx[i] .+ max.(scale .* d[:, i], 0), times)
                zero_line = Point2.(gx[i] .+ z, times)

                if j <= length(traces)
                    traces[j][] = trace
                    positive_traces[j][] = pos_trace
                    zero_lines[j][] = zero_line 
                else
                    push!(traces, Observable(trace))
                    push!(positive_traces, Observable(pos_trace))
                    push!(zero_lines, Observable(zero_line))
                end
                st += wiggle_trace_increment*dgx
                j += 1
            end
        end
        
    end

    Makie.Observables.onany(update_plot, d, gx)

    update_plot(d[], gx[])

    for i = 1:length(traces)
        if wp.fillbands[]
            band!(wp, zero_lines[i], positive_traces[i], color=wp.wiggle_fill_color)
        end
        lines!(wp, traces[i], color=wp.wiggle_line_color, linewidth=wp.trace_width)
    end

    wp
end
