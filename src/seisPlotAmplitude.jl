"""
    SeisPlotAmplitude(d,fmax,dy ; <keyword arguments>)

Plot amplitude-frequency 2D seismic data `d`


# Arguments
- `d::Array{Real,2}`: 2D data to plot.

# Keyword arguments
- `fig=nothing`: the figure we want to plot on. If not supplied, one will be created and returned.
- `ax=nothing`: the axis we want to plot on. If not supplied, one will be created and returned.

- `fmax=100`: maximum frequency.
- `dy=0.004`: time sample interval.
- `normalize=false`: whether or not to normalize the data

- `color=:red`: color of the plot.
- `label=""`: plot label to be included in legend

# Example
```julia
julia> d = SeisLinearEvents();
julia> f, ax = SeisPlotAmplitude(d,100,0.004);
```

Author: Firas Al Chalabi (2024)
"""
function seisPlotAmplitude(d::Array{<:Real, 2}; fig=nothing, ax=nothing, fmax=100, dy=0.004,
                           normalize=false, color=:black, label="")

    if isnothing(fig)
        fig = Figure()
    end

    if isnothing(ax)
        ax = Axis(fig[1,1])
        ax.title = "Amplitude Spectrum"
        ax.xlabel = "Frequency (Hz)"
        ax.ylabel = "Amplitude"
        ax.xgridvisible = true
    end

    seisamplitudeplot!(ax, d, fmax=fmax, dy=dy, normalize=normalize, color=color, label=label)

    return fig, ax
end
