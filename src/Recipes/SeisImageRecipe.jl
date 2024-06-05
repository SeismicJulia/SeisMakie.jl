"""
    seisimage(d; <keyword arguments>);
    seisimage!(ax, d; <keyword arguments>);

Recipe to plot time-space, color plot of 2D seismic data `d`.

# Arguments:
- `d::Matrix{<:AbstractFloat}`: 2D seismic data to be plotted.

# Keyword Arguments:
- `ox=0`: first point of x-axis.
- `dx=1`: increment of x-axis.
- `oy=0`: first point of y-axis.
- `dy=1`: increment of y-axis.

- `pclip=98`: percentile for determining clip.
- `vmin=nothing`: minimum value used in colormapping data.
- `vmax=nothing`: maximum value used in colormapping data.

- `cmap=:seismic`: the colormap to be used.

# Examples
```julia
julia> d = SeisLinearEvents();
julia> f, ax, img = seisimage(d)
```
```julia
julia> d = SeisLinearEvents(); f = Figure(); ax = Axis(f)
julia> img = seisimage!(ax, d)
```

Author: Firas Al Chalabi (2024)
Credits: Aaron Stanton (2015)
- Most of the code in this file is taken from SeisPlot.jl written by Aaron Stanton.
"""
@recipe(SeisImagePlot, d) do scene
    Attributes(
        ox = 0,
        dx = 1,
        oy = 0,
        dy = 1,

        pclip = 98,
        vmin = nothing,
        vmax = nothing,

        cmap = :seismic,
    )
end

function Makie.plot!(img::SeisImagePlot{<:Tuple{AbstractMatrix{<:Real}}})

    transposed_d = Observable{Any}()

    x = Observable{Any}()
    y = Observable{Any}()

    colorrange = Observable{Any}()


    function update_plot(d, ox, oy, dx, dy, pclip, vmin, vmax)
        transposed_d[] = d'

        x[] = (ox, ox + size(d,2)*dx)
        y[] = (oy, oy + size(d,1)*dy)

        if (isnothing(vmin) || isnothing(vmax))
            a, b = __calculate_pclip(d, pclip=pclip)
        else
            a = vmin
            b = vmax
        end

        colorrange[] = (a, b)

    end

    Makie.Observables.onany(update_plot, img.d, img.ox, img.oy, img.dx, img.dy, img.pclip, img.vmin, img.vmax)

    update_plot(img.d[], img.ox[], img.oy[], img.dx[], img.dy[], img.pclip[], img.vmin[], img.vmax[])
        
    if (colorrange[][1] != colorrange[][2])
        image!(img, x, y, transposed_d, colorrange=colorrange, colormap=img.cmap)
    else
        image!(img, x, y, transposed_d, colormap=img.cmap)
    end
    img
end
