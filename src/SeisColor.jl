"""
    SeisColor(d; <keyword arguments>)

Plot time-space, color plot of 2D seismic data `d`.

# Arguments:
- `d::Matrix{<:AbstractFloat}`: 2D seismic data to be plotted.

# Keyword Arguments:
- `fig::Figure=nothing`: the figure we want to plot on. If not supplied, one will be created and returned.

- `ox=0`: first point of x-axis.
- `dx=1`: increment of x-axis.
- `oy=0`: first point of y-axis.
- `dy=1`: increment of y-axis.

- `pclip=98`: percentile for determining clip.
- `vmin=nothing`: minimum value used in colormapping data.
- `vmax=nothing`: maximum value used in colormapping data.

- `cmap=:viridis`: the colormap to be used.

Return the figure and axis corresponding to d.

# Example
```julia
julia> d = SeisLinearEvents(); SeisColor(d);
```
"""
function SeisColor(d; 
                fig=nothing, ox=0, dx=1, oy=0, dy=1, 
                pclip=98, vmin=nothing, vmax=nothing, cmap=:viridis, kwargs...)

    if isnothing(fig)
        fig = Figure()
    end

    ax = __create_axis(fig[1,1])
    xlims!(ax, low=ox-dx, high=ox+size(d,2)*dx)
    img = seiscolorbase!(ax, d, ox=ox, dx=dx, oy=oy, dy=dy, pclip=pclip, vmin=vmin, vmax=vmax, cmap=cmap)
    Colorbar(fig[1,2], img)

    return fig, ax
end