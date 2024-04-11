"""
    seisamplitude(d; <keyword arguments>)
    seisamplitude!(ax, d; <keyword arguments>)

Plot amplitude-frequency 2D seismic data `d`.


# Arguments
- `d::Array{Real,2}`: 2D data to plot.

# Keyword arguments
- `fmax=100`: maximum frequency.
- `dy=0.004`: time sample interval.
- `normalize=false`: whether or not to normalize the data

- `color=:black`: color of the plot.
- `label=""`: plot label to be included in legend

# Examples
```julia
julia> d = SeisLinearEvents();
julia> f, ax, amp = seisamplitude(d)
```
```julia
julia> d = SeisLinearEvents(); f = Figure(); ax = Axis(f)
julia> amp = seisamplitude!(ax, d)
```

Author: Firas Al Chalabi (2024)
Credits: Aaron Stanton (2015)
- Most of the code in this file is taken from SeisPlot.jl written by Aaron Stanton.
"""
@recipe(SeisAmplitudePlot, d) do scene
    Attributes(
        fmax=100,
        dy=0.004,

        normalize=false,

        color = :black,
        label = "",
    )
end

function Makie.plot!(amp::SeisAmplitudePlot{<:Tuple{AbstractMatrix{<:Real}}})

    nx = size(amp.d[], 2)
    df = 1/amp.dy[]/size(amp.d[], 1)
    FMAX = df*size(amp.d[], 1)/2
    if amp.fmax[] > FMAX
        amp.fmax[] = FMAX
    end
    nf = convert(Int32, floor((size(amp.d[], 1)/2)*amp.fmax[]/FMAX))
    y = fftshift(sum(abs.(fft(amp.d[], 1)), dims=2))/nx
    y = y[round(Int,end/2):round(Int, end/2)+nf]

    if amp.normalize[]
        norm = maximum(y[:])
        if (norm > 0.)
            y = y/norm
        end
    end

    x = collect(0:df:amp.fmax[])

    lines!(amp, x, y, color=amp.color[], label=amp.label[])

    amp
end
