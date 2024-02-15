"""
    SeisPlotTX(d; <keyword arguments>)

Plot time-space, 2D seismic data `d` with color, wiggles or overlay.

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

- `pclip=98`: percentile for determining clip.
- `vmin=nothing`: minimum value used in colormapping data.
- `vmax=nothing`: maximum value used in colormapping data.

- `wiggle_fill_color=:black`: color for filling the positive wiggles.
- `wiggle_line_color=:black`: color for wiggles' lines.
- `wiggle_trace_increment=1`: increment for wiggle traces.
- `xcur=1.2`: wiggle excursion in traces corresponding to clip.

- `colormap=:viridis`: the colormap to be used for color and overlay plots.

- `style`: determines the type of plot. Can be either "wiggle"/"wiggles", "color", "overlay".

Return the figure and axis corresponding to d.

# Example
```julia
julia> d = SeisLinearEvents(); SeisPlotTX(d);
```
"""
function SeisPlotTX(d; style="color", kwargs...)
    
    if style == "overlay"
        return SeisOverlay(d; kwargs...)
    elseif style == "wiggles" || style == "wiggle"
        return SeisWiggle(d; kwargs...)
    else
        return SeisColor(d; kwargs...)
    end

end

