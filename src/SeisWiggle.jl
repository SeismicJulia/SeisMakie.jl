"""
    SeisWiggle(d; <keyword arguments>)

Plot time-space, wiggle plot of 2D seismic data `d`.

# Arguments:
- `d::Matrix{<:AbstractFloat}`: the measured seismic traces. Number of columns corresponds to number
                                of traces whereas number of rows corresponds to the number of times
                                amplitude was measured for each trace

# Keyword Arguments:
- `fig::Figure=nothing`: the figure we want to plot on. If not supplied, one will be created and returned.

- `gx::Vector{<:Real}=nothing`: the real coordinates of the seismometers corresponding to the traces in d
- `ox=0`: first point of x-axis.
- `dx=1`: increment of x-axis.
- `oy=0`: first point of y-axis.
- `dy=1`: increment of y-axis.

- `wiggle_fill_color=:black`: color for filling the positive wiggles.
- `wiggle_line_color=:black`: color for wiggles' lines.
- `wiggle_trace_increment=1`: increment for wiggle traces.
- `xcur=1.2`: wiggle excursion in traces.

Return the figure and axis corresponding to d.

# Example
```julia
julia> d = SeisLinearEvents(); SeisWiggle(d);
```
"""
function SeisWiggle(d; 
                fig=nothing, gx=nothing, ox=0, dx=1, oy=0, dy=1,
                xcur=1.2, wiggle_trace_increment=1, trace_width=0.7, 
                wiggle_line_color=:black, wiggle_fill_color=:black,
                kwargs...)

    if isnothing(fig)
        fig = Figure()
    end

    ax = __create_axis(fig[1,1])
    if !isnothing(gx)
        ox = gx[1]
        dx = minimum([gx[i]-gx[i-1] for i = 2:length(gx)])
    end
    xlims!(ax, low=ox-dx, high=ox+size(d,2)*dx)
    seiswigglebase!(ax, d, gx=gx, ox=ox, dx=dx, oy=oy, dy=dy, xcur=xcur, wiggle_trace_increment=wiggle_trace_increment, 
                    wiggle_line_color=wiggle_line_color, wiggle_fill_color=wiggle_fill_color,
                    trace_width=trace_width)

    return fig, ax
end