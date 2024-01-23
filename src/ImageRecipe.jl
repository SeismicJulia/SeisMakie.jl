@recipe(SeisImage, d) do scene
    Attributes(
        dx = 1, 
        dy = 1,
        pclip = 98,
    )
end

function Makie.plot!(img::SeisImage{<:Tuple{AbstractMatrix{<:Real}}})
    d = img.d

    x = (1, 100)
    y = (1, 500)

    function update_plot(d)
        
    end

    Makie.Observables.onany(update_plot, d)

    image!(x, y, d[]')

    img
end