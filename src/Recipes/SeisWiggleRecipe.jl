@recipe(SeisWiggleBase, d) do scene
    Attributes(
        wiggle_line_color = :black,
        wiggle_fill_color = :black,

        trace_width = 0.7,

        gx = nothing,
        ox = 0,
        dx = 1,

        oy = 0,
        dy = 1,

        xcur = 1.2,
        wiggle_trace_increment = 1,
        #wiggle_difference = 1,

        fillbands = true,
    )
end

function Makie.plot!(wp::SeisWiggleBase{<:Tuple{AbstractMatrix{<:Real}}})
    
    d = wp.d
    gx = wp.gx

    ox = wp.ox[]
    dx = wp.dx[]

    oy = wp.oy[]
    dy = wp.dy[]
    
    xcur = wp.xcur[]
    wiggle_trace_increment = wp.wiggle_trace_increment[]


    if isnothing(gx[])
        gx[] = [ox+(i-1)*dx for i in range(start=1, stop=size(d[], 2))]
    end
    
    traces = Observable(Vector{Point2f}[])
    positive_traces = Observable(Vector{Point2f}[])
    zero_lines = Observable(Vector{Point2f}[])

    function update_plot(d, gx)                        
        empty!(traces[])
        empty!(positive_traces[])
        empty!(zero_lines[])
                             
        dgx = minimum([gx[i]-gx[i-1] for i in 2:length(gx)])
        max_perturb = maximum(abs, d)
        times = oy:dy:(dy*(size(d, 1)-1)+oy)
        z = zeros(length(size(d, 1)))
        scale = wiggle_trace_increment*dgx*xcur/max_perturb

        for i = 1:wiggle_trace_increment:length(gx)
            trace = Point2.(gx[i] .+ (scale .* d[:, i]), times)
            pos_trace = Point2.(gx[i] .+ max.(scale .* d[:, i], 0), times)
            zero_line = Point2.(gx[i] .+ z, times)
            push!(traces[], trace)
            push!(positive_traces[], pos_trace)
            push!(zero_lines[], zero_line)
        end
    end 

    Makie.Observables.onany(update_plot, d, gx)

    update_plot(d[], gx[])

    for i = 1:length(traces[])
        if wp.fillbands[]
            band!(wp, zero_lines[][i], positive_traces[][i], color=wp.wiggle_fill_color)
        end
        lines!(wp, traces[][i], color=wp.wiggle_line_color, linewidth=wp.trace_width)
    end
    wp
end
