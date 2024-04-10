"""
    SeisPlotTX(d; <keyword arguments>)

Plot time-space, 2D seismic data `d` with image, wiggles or overlay.

# Arguments:
- `d::Matrix{<:AbstractFloat}`: the measured seismic traces. Number of columns corresponds to number
                                of traces whereas number of rows corresponds to the number of times
                                amplitude was measured for each trace

# Keyword Arguments:
- `fig=nothing`: the figure we want to plot on. If not supplied, one will be created and returned.

- `gx::Vector{<:Real}=nothing`: the real coordinates of the seismometers corresponding to the traces in d. Only 
                                supported with style="wiggles"
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

- `cmap=:seismic`: the colormap to be used for image and overlay plots.

- `style`: determines the type of plot. Can be either "wiggle"/"wiggles", "image", "overlay".

Return the figure and axis corresponding to d.

# Example
```julia
julia> d = SeisLinearEvents();
julia> f, ax = SeisPlotTX(d);
```

Author: Firas Al Chalabi (2024)
"""
function seisPlotTX(d;
                    fig=nothing, gx=nothing, ox=0, dx=1, oy=0, dy=1, xcur=1.2, wiggle_trace_increment=1,
                    pclip=98, vmin=nothing, vmax=nothing,
                    wiggle_line_color=:black, wiggle_fill_color=:black,trace_width=0.7,
                    cmap=:seismic, style="image")

    if isnothing(fig)
        fig = Figure()
    end

    ax = __create_axis(fig[1,1])

    if style == "overlay"
        overlay = seisoverlayplot!(ax, d;
                               ox=ox, dx=dx, oy=oy, dy=dy, pclip=pclip, vmin=vmin, vmax=vmax, xcur=xcur,
                               wiggle_trace_increment=wiggle_trace_increment,
                               wiggle_line_color=wiggle_line_color,
                               wiggle_fill_color=wiggle_fill_color,
                               trace_width=trace_width, cmap=cmap)

        Colorbar(fig[1, 2], overlay)

        xlims!(ax, low=ox, high=ox+size(d,2)*dx)

    elseif style == "wiggles" || style == "wiggle"
        if !isnothing(gx)
            ox = gx[1]
            dx = wiggle_trace_increment*minimum([gx[i]-gx[i-1] for i = 2:length(gx)])
        end

        seiswiggleplot!(ax, d; gx=gx, ox=ox, dx=dx, oy=oy, dy=dy, xcur=xcur,
                    wiggle_trace_increment=wiggle_trace_increment,
                    wiggle_line_color=wiggle_line_color,
                    wiggle_fill_color=wiggle_fill_color,
                    trace_width=trace_width)

        xlims!(ax, low=ox-dx, high=ox+size(d,2)*dx)

    else
        img = seisimageplot!(ax, d; ox=ox, dx=dx, oy=oy, dy=dy, pclip=pclip, vmin=vmin, vmax=vmax, cmap=cmap)
        Colorbar(fig[1,2], img)

        xlims!(ax, low=ox, high=ox+size(d,2)*dx)
    end

    return fig, ax

end

