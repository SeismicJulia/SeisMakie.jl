# @recipe(Wiggle) do scene
#     Attributes(
#         # vertical = false, 
#     )
# end
"""
    wiggle(gx, d, dt)
    wiggle!(ax, gx, d, dt)

Plots wiggle traces of seismic data.

# Arguments:
- `gx::Vector{<:Real}`: the positions of the seismometers(?) corresponding to the traces in d
- `d::Matrix{<:AbstractFloat}`: the measured seismic traces. Number of columns corresponds to number
                                of traces whereas number of rows corresponds to the number of times
                                amplitude was measured for each trace
- `dt`::AbstractFloat: the amount of time between each measurement of amplitude
"""
@recipe(Wiggle, d) do scene
    Attributes(
        color = :black,
        linewidth = 0.7,

        gx = "NULL",
        ox = 0,
        dx = 1,

        ot = 0,
        dt = 1,
    )
end

function Makie.plot!(wp::Wiggle{<:Tuple{AbstractMatrix{<:Real}}})
    
    d = wp.d
    gx = wp.gx
    ox = wp.ox[]
    dx = wp.dx[]

    ot = wp.ot[]
    dt = wp.dt[]


    if gx[] == "NULL"
        gx[] = [ox+(i-1)*dx for i in range(start=1, stop=size(d[], 2))]
    end
    
    traces = Observable(Vector{Point2f}[])
    positive_traces = Observable(Vector{Point2f}[])
    zero_lines = Observable(Vector{Point2f}[])
    ## Add colour functionality

    function update_plot(d, gx)                        
        empty!(traces[])
        empty!(positive_traces[])
        empty!(zero_lines[])
                             
        dgx = minimum([gx[i]-gx[i-1] for i in 2:length(gx)])
        max_perturb = maximum(abs, d)
        times = ot:dt:(dt*(size(d, 1)-1)+ot)
        z = zeros(length(size(d, 1)))
        for i = 1:length(gx)
            trace = Point2.(gx[i] .+ (dgx/max_perturb .* d[:, i]), times)
            pos_trace = Point2.(gx[i] .+ max.(dgx/max_perturb .* d[:, i], 0), times)
            zero_line = Point2.(gx[i] .+ z, times)
            push!(traces[], trace)
            push!(positive_traces[], pos_trace)
            push!(zero_lines[], zero_line)
        end
    end 

    Makie.Observables.onany(update_plot, d, gx)

    update_plot(d[], gx[])

    for i = 1:length(gx[])
        band!(wp, zero_lines[][i], positive_traces[][i], color=wp.color)
        lines!(wp, traces[][i], color=wp.color, linewidth=wp.linewidth)
    end
    wp
end
