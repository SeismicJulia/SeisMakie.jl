"""
    SeisPlotFK(d; <keyword arguments>)

Plot time-space, frequency-wavenumber or amplitude-frequency 2D seismic data `d`
with color, wiggles or overlay.

# Arguments
- `d::Matrix{<:AbstractFloat}`: 2D data to plot.

# Keyword arguments:
- `fig::Figure=nothing`: the figure we want to plot on. If not supplied, one will be created and returned.

- `pclip=99.9`: percentile for determining clip.
- `vmin=nothing`: minimum value used in colormapping data.
- `vmax=nothing`: maximum value used in colormapping data.

- `fmax=100`: maximum frequency for `"FK"` or `"Amplitude"` plot.

- `ox=0`: first point of x-axis.
- `dx=1`: increment of x-axis.
- `oy=0`: first point of y-axis.
- `dy=1`: increment of y-axis.

- `cmap=:PuOr`: colormap for  `"color"` or `"overlay"` style.

Return the figure and axis corresponding to d.

# Example
```julia
julia> d = SeisLinearEvents(); SeisPlotFK(d);
```
"""
function SeisPlotFK(d; fig=nothing, ox=0, dx=1, oy=0, dy=1, fmax=100,
                    pclip=99.9, vmin=nothing, vmax=nothing, cmap=:PuOr)

    if isnothing(fig)
        fig = Figure()
    end

    ax = __create_axis(fig[1, 1])

    dk = 1/dx/size(d, 2)
    kmin = -dk*size(d, 2)/2
    kmax =  dk*size(d, 2)/2

    df = 1/dy/size(d, 1)
    FMAX = df*size(d, 1)/2
    if fmax > FMAX
        fmax = FMAX
    end
    nf = convert(Int32, floor((size(d, 1)/2)*fmax/FMAX))
    D = abs.(fftshift(fft(d)))
    D = D[round(Int,end/2):round(Int,end/2)+nf, :]
    if (isnothing(vmin) || isnothing(vmax))
        a = 0.
        if (pclip<=100)
            b = quantile(abs.(D[:]), (pclip/100))
        else
            b = quantile(abs.(D[:]), 1)*pclip/100
        end
    else
        a = vmin
        b = vmax
    end

    image!(ax, (kmin, kmax), (0.0, 0.5), D', colorrange=(a, b), colormap=:PuOr)

    ax.xlabel = "Wavenumber (1/m)"
    ax.ylabel = "Frequency (Hz)"

    ax.xlabelsize = 14
    ax.ylabelsize = 14

    ax.xticklabelsize = 11
    ax.yticklabelsize = 11

    return fig, ax
end