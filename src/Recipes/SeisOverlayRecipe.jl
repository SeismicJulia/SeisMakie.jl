@recipe(SeisOverlayBase, d) do scene
    Attributes(
        trace_color = :black,
        trace_width = 0.7,
    
        gx = nothing,
        ox = 0,
        dx = 1,
    
        oy = 0,
        dy = 1,

        xcur = 1,
        wiggle_trace_increment = 1,
    
        pclip = 98,
        vmin = nothing,
        vmax = nothing,
    
        x = (1, 500), 
        y = (1, 100),

        cmap = :viridis
    )
end

function Makie.plot!(overlay::SeisOverlayBase{<:Tuple{AbstractMatrix{<:Real}}})

    if !isnothing(overlay.gx[])
        overlay.ox[] = overlay.gx[][1]
        overlay.dx[] = (overlay.gx[][end] - overlay.gx[][1]) / length(overlay.gx[]) 
    end

    seiscolorbase!(overlay, overlay.d[], ox=overlay.ox[], dx=overlay.dx[], oy=overlay.oy[], dy=overlay.dy[], colormap=overlay.cmap[],
                    vmin=overlay.vmin[], vmax=overlay.vmax[], pclip=overlay.pclip[])
    seiswigglebase!(overlay, overlay.d[],  gx=overlay.gx[], ox=overlay.ox[],  dx=overlay.dx[], oy=overlay.oy[], dy=overlay.dy[],
            xcur=overlay.xcur[], wiggle_trace_increment=overlay.wiggle_trace_increment[], trace_color=overlay.trace_color[], 
            trace_width=overlay.trace_width[], fillbands=false)

    overlay
end

function Makie.extract_colormap(pl::Plot{seisoverlaybase, Tuple{Matrix{Float64}}})
    # Return the ColorMapping of the SeisColor plot
    #   -  typeof(pl.plots[1] is seiscolorbase) = Plot{SeisMakie.seiscolorbase, Tuple{Matrix{Float64}}}
    #   -  typeof(pl.plots[1].plots[1]) = Image{Tuple{ClosedInterval{Float32}, ClosedInterval{Float32}, Matrix{Float32}}}
    return Makie.extract_colormap(pl.plots[1].plots[1])
end