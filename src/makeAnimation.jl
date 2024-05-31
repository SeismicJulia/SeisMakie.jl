function makeAnimation(
    filename::String,
    A::AbstractArray{<:Real};
    pclip = 98,
    ox = 0,
    dx = 1,
    oy = 0,
    dy = 1,
    framerate::Integer=30
)

    # Creating an observable that triggers a change in the figure after a change in its value
    obs = Observable(A[:, :, 1])

    iterations = 1:size(A,3)

    fig = Figure()
    ax = Axis(fig[1,1], yreversed=true, xautolimitmargin=(0,0), yautolimitmargin=(0,0))

    # Creating a plot based on observable obs. If obs[] changes the plot automatically changes
    seisimageplot!(ax, obs, pclip=pclip, ox=ox, dx=dx, oy=0, dy=1)

    record(fig, filename, iterations; framerate=30) do it
        # modifying the Observable variable to change the plot
        obs[] = A[:, :, it]
    end

    return nothing
end