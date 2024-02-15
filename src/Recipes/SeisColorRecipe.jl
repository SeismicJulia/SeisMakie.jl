@recipe(SeisColorBase, d) do scene
    Attributes(
        ox = 0,
        dx = 1, 
        oy = 0,
        dy = 1,

        pclip = 98,
        vmin = nothing,
        vmax = nothing,

        x = nothing,
        y = nothing,

        cmap = :viridis,
    )
end

function Makie.plot!(img::SeisColorBase{<:Tuple{AbstractMatrix{<:Real}}})
    
    ## Copied from SeisPlot.SeisPlotTX
    if (isnothing(img.vmin[]) || isnothing(img.vmax))
        if (img.pclip[]<=100)
            a = -quantile(abs.(img.d[][:]), (img.pclip[]/100))
        else
            a = -quantile(abs.(img.d[][:]), 1)*img.pclip[]/100
        end
            b = -a
    else
        a = img.vmin[]
        b = img.vmax[]
    end
    
    if isnothing(img.y[])
        img.y[] = (img.oy[], img.oy[]+size(img.d[],1)*img.dy[])
    end

    if isnothing(img.x[])
        img.x[] = (img.ox[]-img.dx[], img.ox[]+size(img.d[],2)*img.dx[])
    end

    image!(img, img.x[], img.y[], img.d[]', colorrange=(a, b), colormap=img.cmap[])
    # d = img.d[][x[1]:x[2], y[1]:y[2]]
    # image!(img, y, x, d', colorrange=(a, b), colormap=img.colormap[])
    
    img
end