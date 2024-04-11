"""
    seisfk(d; <keyword arguments>)
    seisfk!(ax, d; <keyword arguments>)

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

# Examples
```julia
julia> d = SeisLinearEvents();
julia> f, ax, fk = seisfk(d)
```
```julia
julia> d = SeisLinearEvents(); f = Figure(); ax = Axis(f)
julia> fk = seisfk!(ax, d)
```

Author: Firas Al Chalabi (2024)
Credits: Aaron Stanton (2015)
- Most of the code in this file is taken from SeisPlot.jl written by Aaron Stanton.
"""
@recipe(SeisFKPlot, d) do scene
    Attributes(
        dx=1,
        dy=1,
        fmax=100,

        pclip=99.9,
        vmin=nothing,
        vmax=nothing,

        cmap=:PuOr
    )
end

function Makie.plot!(fk::SeisFKPlot{<:Tuple{AbstractMatrix{<:Real}}})

    dk = 1/fk.dx[]/size(fk.d[], 2)
    kmin = -dk*size(fk.d[], 2)/2
    kmax =  dk*size(fk.d[], 2)/2

    df = 1/fk.dy[]/size(fk.d[], 1)
    FMAX = df*size(fk.d[], 1)/2
    if fk.fmax[] > FMAX
        fk.fmax[] = FMAX
    end
    nf = convert(Int32, floor((size(fk.d[], 1)/2)*fk.fmax[]/FMAX))
    D = abs.(fftshift(fft(fk.d[])))
    D = D[round(Int,end/2):round(Int,end/2)+nf, :]

    if (isnothing(fk.vmin[]) || isnothing(fk.vmax[]))
        a = 0.
        if (fk.pclip[] <= 100)
            b = quantile(abs.(D[:]), (fk.pclip[]/100))
        else
            b = quantile(abs.(D[:]), 1)*fk.pclip[]/100
        end
    else
        a = fk.vmin[]
        b = fk.vmax[]
    end

    image!(fk, (kmin, kmax), (0.0, fk.fmax[]), D', colorrange=(a, b), colormap=fk.cmap[])

end
