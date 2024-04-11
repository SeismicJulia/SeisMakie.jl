"""
    SeisPlotFK(d; <keyword arguments>)

Plot frequency-wavenumber 2D seismic data `d`.

# Arguments
- `d::Matrix{<:AbstractFloat}`: 2D data to plot.

# Keyword arguments:
- `fig=nothing`: the figure we want to plot on. If not supplied, one will be created and returned.

- `pclip=99.9`: percentile for determining clip.
- `vmin=nothing`: minimum value used in colormapping data.
- `vmax=nothing`: maximum value used in colormapping data.

- `fmax=100`: maximum frequency for `"FK"` or `"Amplitude"` plot.

- `dx=1`: increment of x-axis.
- `dy=1`: increment of y-axis.

- `cmap=:PuOr`: colormap

Return the figure and axis corresponding to d.

# Example
```julia
julia> d = SeisLinearEvents(); 
julia> f, ax = SeisPlotFK(d);
```

Author: Firas Al Chalabi (2024)
"""
function seisPlotFK(d; fig=nothing, dx=1, dy=1, fmax=100,
                    pclip=99.9, vmin=nothing, vmax=nothing, cmap=:PuOr)

    if isnothing(fig)
        fig = Figure()
    end

    ax = __create_axis(fig[1, 1])

    seisfkplot!(ax, d, dx=dx, dy=dy, fmax=fmax, pclip=pclip, vmin=vmin, vmax=vmax, cmap=cmap)

    ax.xlabel = "Wavenumber (1/m)"
    ax.ylabel = "Frequency (Hz)"

    ax.xlabelsize = 14
    ax.ylabelsize = 14

    ax.xticklabelsize = 11
    ax.yticklabelsize = 11

    return fig, ax
end