"""
    SeisOverlay(d; <keyword arguments>)

Plot time-space, overlay plot of 2D seismic data `d`.

# Arguments:
- `d::Matrix{<:AbstractFloat}`: 2D seismic data to be plotted.

# Keyword Arguments:
- `fig::Figure=nothing`: the figure we want to plot on. If not supplied, one will be created and returned.

- `gx::Vector{<:Real}=nothing`: the real coordinates of the seismometers corresponding to the traces in d
- `ox=0`: first point of x-axis.
- `dx=1`: increment of x-axis.
- `oy=0`: first point of y-axis.
- `dy=1`: increment of y-axis.

- `pclip=98`: percentile for determining clip.
- `vmin=nothing`: minimum value used in colormapping data.
- `vmax=nothing`: maximum value used in colormapping data.

- `wiggle_fill_color=:black`: color for filling the positive wiggles.
- `wiggle_line_color=:black`: color for wiggles' lines.
- `wiggle_trace_increment=1`: increment for wiggle traces.
- `xcur=1.2`: wiggle excursion in traces corresponding to clip.

- `cmap=:viridis`: the colormap to be used.

Return the figure and axis corresponding to d.

# Example
```julia
julia> d = SeisLinearEvents(); SeisOverlay(d);
```
"""
function SeisOverlay(d;
                    fig=nothing, ox=0, dx=1, oy=0, dy=1,  gx=nothing, xcur=1.2, wiggle_trace_increment=1,
                    pclip=98, vmin=nothing, vmax=nothing, 
                    wiggle_line_color=:black, wiggle_fill_color=:black,trace_width=0.7, 
                    cmap=:viridis, kwargs...)
    
    if isnothing(fig)
        fig = Figure()
    end

    ax = __create_axis(fig[1, 1])
    xlims!(ax, low=ox-dx, high=ox+size(d,2)*dx)
    overlay = seisoverlaybase!(ax, d, ox=ox, dx=dx, oy=oy, dy=dy, gx=gx, pclip=pclip, vmin=vmin, vmax=vmax, xcur=xcur,
                            wiggle_trace_increment=wiggle_trace_increment, wiggle_line_color=wiggle_line_color,
                            wiggle_fill_color=wiggle_fill_color, trace_width=trace_width, cmap=cmap)
    
    Colorbar(fig[1, 2], overlay)

    return fig, ax
end