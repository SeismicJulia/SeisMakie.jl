using SeisMakie
using SeisProcessing
using Random
using Test

@testset "SeisMakie.jl" begin
    
    d = SeisLinearEvents()

    dx = 10
    dy = 0.004

    @testset "SeisWiggleRecipe" begin
        gx = [ dx*(i-1) for i=1:size(d,2) ]
        # create a random permutation vector to sample gx and d
        p = (randsubseq(gx, 0.85) .÷ dx) .+ 1
        gx = gx[p]

        f, ax, wp = seiswiggle(d[:, p], gx=gx, dy=dy, xcur=2, wiggle_trace_increment=4)

        @test true
    end

    @testset "SeisImageRecipe" begin

        f, ax, img = seisimage(d, dx=dx, dy=dy, pclip=97, cmap=:viridis)

        @test true

    end

    @testset "SeisOverlayRecipe" begin

        f, ax, ov = seisoverlay(d, dx=dx, dy=dy, xcur=2, wiggle_trace_increment=4, pclip=97, cmap=:viridis)

        @test true

    end

    @testset "SeisFKRecipe" begin
        
        f, ax, fk = seisfk(d, dx=dx, dy=dy, pclip=97, fmax=90)

        @test true
    end

    @testset "SeisAmplitudeRecipe" begin
        
        f, ax, amp = seisamplitude(d, dy=dy, fmax=90)

        @test true
    end

    @testset "SeisPlotTX" begin
        gx = [ dx*(i-1) for i=1:size(d,2) ]
        # create a random permutation vector to sample gx and d
        p = (randsubseq(gx, 0.85) .÷ dx) .+ 1
        gx = gx[p]
        f, ax = SeisPlotTX(d[:, p], gx=gx, dy=dy, xcur=2, wiggle_trace_increment=4, style="wiggle")
        @test true
        f, ax = SeisPlotTX(d, dx=dx, dy=dy, pclip=97, cmap=:viridis, style="image")
        @test true
        f, ax = SeisPlotTX(d, dx=dx, dy=dy, xcur=2, wiggle_trace_increment=4, pclip=97, cmap=:viridis, style="overlay")
        @test true
    end

    @testset "SeisPlotFK" begin
        f, ax = SeisPlotFK(d, dx=dx, dy=dy, pclip=97, fmax=90)

        @test true
    end

    @testset "SeisAmplitude" begin
        f, ax = SeisPlotAmplitude(d, dy=dy, fmax=90)

        @test true
    end

end
