### A Pluto.jl notebook ###
# v0.19.37

using Markdown
using InteractiveUtils

# ╔═╡ 93296b66-bca6-11ee-0787-99798c15a928
begin
	using Pkg
	Pkg.activate(".")
	Pkg.precompile()
	Pkg.resolve()
	using CairoMakie
	using SeisMakie
	
	using SeisProcessing
	using Random
end

# ╔═╡ 90077fbb-2384-4d12-b51a-f52758049e49
md"""
# SeisMakie Showcase
"""

# ╔═╡ 0d86b756-00a0-4484-8cee-2c0330ed438f


# ╔═╡ 62e31cae-8deb-49a5-a6a1-54a772b48ff6
md"""
## Initializing Data
We first initialize some data to plot using functions from the SeisProcessing package.
"""

# ╔═╡ e12751b3-0c8d-4655-b606-ae94d670b0d0
begin
	D1= SeisParabEvents()
	D2= SeisLinearEvents()

	# D holds the trace data to be plotted
	D = SeisAddNoise( D1 + 0.1*D2,2)
	nothing
end

# ╔═╡ abe64b2a-f192-4e3b-ba3e-f26286b1a38d
md"""
## SeisPlotTX
SeisPlotTX allows us to plot either a wiggle, image, or overlay plot by specifying a `style` keyword. 
"""

# ╔═╡ 0c3fcf92-8924-49ac-b487-a9dc372b2739
md"""
### Wiggle Plots
"""

# ╔═╡ 98b06ba3-7f03-4649-9627-33c6c7108141
begin
	function base_wiggle()
		f, ax = SeisPlotTX(D, style="wiggles")
		f
	end
	base_wiggle()
end

# ╔═╡ 2d59475e-728c-47ef-8e1c-13750857f6f8


# ╔═╡ 25c72bf7-28ce-4f6b-b4c4-24be2f51a5f9
begin
	function start_and_interval_wiggle()
		ox, dx = 1000, 3
		oy, dy = 500, 5
		f, ax = SeisPlotTX(D, ox=ox, dx=dx, oy=oy, dy=dy, style="wiggle")
		f
	end
	start_and_interval_wiggle()
end

# ╔═╡ 3595a191-495f-4263-8312-09e5d9c3d252
md"""
You can also provide real coordinates for trace positions in the form of an iterable of the same size as the trace matrix's second dimension n.
"""

# ╔═╡ 13980acc-8aa1-4d87-ab7e-c1a599e0483d
begin
	function real_coords()
		d = SeisLinearEvents()
		dx = 10
		dt = 0.004
		gx = [ dx*(i-1) for i=1:size(d,2) ]
		# create a random permutation vector to sample gx and dependent
		p = (randsubseq(gx, 0.85) .÷ dx) .+ 1
		gx = gx[p]
		d = d[:, p]
	
		f, ax = SeisPlotTX(d, gx=gx, style="wiggle")
		f
	end
	real_coords()
end

# ╔═╡ f83180f3-157c-4f6c-9ed5-e41bf58ecc6d
md"""
You can also provide an excursion parameter if desired.
"""

# ╔═╡ 38fcc0c0-aaaa-4777-b67c-9cc5c9289a91
begin
	function excursion()
		f, ax = SeisPlotTX(D, xcur=5, style="wiggle")
		f
	end
	excursion()
end

# ╔═╡ 7ac69279-0c12-45e5-ae6d-3a5ffa199dec


# ╔═╡ 9a61b3d7-3a77-417d-b60b-7172050167e4
begin
	function trace_increment()
		f, ax = SeisPlotTX(D, wiggle_trace_increment=4, style="wiggle")
		f
	end
	trace_increment()
end

# ╔═╡ 63eb66c8-01eb-4e5b-bb3e-469de4eb0697
md"""
You can also change the colour scheme of wiggle plots, if desired.
"""

# ╔═╡ e6f38a8d-3db9-47ed-801e-2f434d2ef70c
begin
	function formatting()
		f, ax = SeisPlotTX(D, wiggle_trace_increment=4, wiggle_line_color=:orange, wiggle_fill_color=:purple, style="wiggle")
		f
	end
	formatting()
end

# ╔═╡ a66db96a-a6f1-4628-8a89-d8b2744eb3b5
md"""
### Image Plots
"""

# ╔═╡ 9179ea73-224c-4291-8cc5-4617524a0b81
begin
	function base_image()
		f, ax = SeisPlotTX(D, style="image")
		f
	end
	base_image()
end

# ╔═╡ 6f574b34-0f78-4b61-bac0-047eaad04e9c
md"""
You can also specify starting coordinates and intervals between adjacent samples for image plots.
"""

# ╔═╡ 0a63424d-ab08-4dd4-bff8-5239ec312733
begin
	function start_and_interval_image()
		ox, dx = 50, 15
		oy, dy = 200, 10
		f, ax = SeisPlotTX(D, ox=ox, dx=dx, oy=oy, dy=dy, style="color")
		f
	end
	start_and_interval_image()
end

# ╔═╡ dc7c0906-269b-4f7f-ba11-f6ba4c4b40d6


# ╔═╡ a546c9bc-7d20-4636-850f-f900194e97e8
begin
	function with_pclip()
		f, ax = SeisPlotTX(D, pclip=95, style="color")
		f
	end
	dx = 1
	with_pclip()
end

# ╔═╡ bd81f1da-ac98-493f-8bc2-d5b1fa635473


# ╔═╡ 9aff572e-683c-4085-878f-8c87c046db6f
begin
	function with_vmin_vmax()
		f, ax = SeisPlotTX(D, vmin=-0.1, vmax=0.4, style="color")
		f
	end
	with_vmin_vmax()
end

# ╔═╡ c14d0c51-164b-41a2-a6df-befd3faf47f2


# ╔═╡ 21cb4890-628a-4331-a163-77fd8b3c9e05
begin
	function with_different_colormap()
		f, ax = SeisPlotTX(D, cmap=:PuOr, style="color")
		f
	end
	with_different_colormap()
end

# ╔═╡ 526287c9-8d28-4357-8313-6f7ba2f2f49b
md"""
### Overlay Plots
You can use any combination of the arguments supplied to SeisWiggle and SeisColor. However, providing real coordinates as in wiggle plots is unsupported.
"""

# ╔═╡ 312a0197-d66c-436d-9452-7c70e4cfaded
begin
	function base_overlay()
		f, ax = SeisPlotTX(D, style="overlay")
		f
	end
	base_overlay()
end

# ╔═╡ 483422b0-666b-4600-a96b-9dd84ca19298
begin
	function overlay_with_args()
		f, ax = SeisPlotTX(D, ox=20, dx=10, oy=500, dy=3, cmap=:seismic, vmin=-0.2, vmax=0.3, style="overlay")
		f
	end
	overlay_with_args()
end

# ╔═╡ ee40ceea-7d3f-4578-902d-d1518f4c7c84
md"""
## SeisPlotFK
"""

# ╔═╡ e12d35e5-4ea6-42f4-a396-92e4d4ebc5c7
begin
	function seisplotfk_demo()
		f, ax = SeisPlotFK(D)
		f
	end
	seisplotfk_demo()
end

# ╔═╡ 3947a6c1-4bbe-4ee0-a3e6-114e481dc49c
md"""
## Modifying Axis Attributes
You can edit axes as shown below. For more info, go to: https://docs.makie.org/stable/reference/blocks/axis/
"""

# ╔═╡ c0246b4f-134b-4413-9cae-f8dd1d4986b7
begin 
	function modifying_axis()
		# All the functions mentioned above return an axis that can be edited
		f, ax = SeisPlotTX(D, pclip=97)
		ax.title = "Overlay Plot (SeisMakie)"
		ax.xlabel = "Trace Number"
		ax.ylabel = "Time (s)"
		ax.xticks = [0, 50, 99]
		f
	end
	modifying_axis()
end

# ╔═╡ b0f62fbd-a577-45a0-be31-aab76babb417
md"""
## Plotting on an Existing Figure
"""

# ╔═╡ cf728878-fefb-4d46-a52e-1d0820248d35
begin
	function multiple_plots()
		# You can initialize a figure first, or use the figure returned
		# by the first function. The position of the axis on the figure is indexed as 
		# shown below
		f = Figure()
		_, wiggle_ax = SeisPlotTX(D, fig=f[1,1], wiggle_trace_increment=4, style="wiggle")
		_, color_ax = SeisPlotTX(D, fig=f[2, 1], style="color")
		_, overlay_ax = SeisPlotTX(D, fig=f[1,2], wiggle_trace_increment=4, style="overlay")

		wiggle_ax.title = "Wiggle"
		color_ax.title = "Color"
		overlay_ax.title = "Overlay"
		f
	end
	multiple_plots()
end

# ╔═╡ 01db2622-4b44-492d-a0f6-838018727e75
md"""
## Saving a figure
"""

# ╔═╡ 8dcce330-fad7-4dde-86c9-f3c732089278
begin
	function save_fig()
		f, ax = SeisOverlay(D)
		save("overlay_plot.png", f)
	end
end

# ╔═╡ 55151c58-ce42-4473-8bee-6ae501b5a891
md"""
## SeisPlotAmplitude
"""

# ╔═╡ f2ac7e44-7a07-4956-9f22-526af10d1fe0
begin
	function spamplitude()
		f, ax = SeisPlotAmplitude(D)
		f
	end
	spamplitude()
end

# ╔═╡ 1fcb8085-02f2-4907-999a-19db73ce4563
begin
	function spamplitude_multiple()
		f, ax = SeisPlotAmplitude(D, label="D")
		SeisPlotAmplitude(D1, ax=ax, label="D1")
		SeisPlotAmplitude(D2, ax=ax, label="D2")
		axislegend(ax, pos = :tr) # Top right position
		#Legend(f[1, 2], ax)
		f
	end
	spamplitude_multiple()
end

# ╔═╡ 9ceb6a8a-9235-49af-94ae-aa762e96aff0
md"""
## SeisDifference
"""

# ╔═╡ 7bad9eb6-9201-4642-b147-193fbb5702fd
begin 
	function horizontal_diff()
		f, ax = SeisDifference(D1, D2)
		f
	end
	horizontal_diff()

end

# ╔═╡ ab183ae7-8e20-4413-b4f4-68000038974c
begin 
	function vertical_diff()
		f, ax1, ax2, ax3 = SeisDifference(D1, D2, horizontal=false)
		f
	end
	vertical_diff()

end

# ╔═╡ Cell order:
# ╟─90077fbb-2384-4d12-b51a-f52758049e49
# ╠═0d86b756-00a0-4484-8cee-2c0330ed438f
# ╠═93296b66-bca6-11ee-0787-99798c15a928
# ╟─62e31cae-8deb-49a5-a6a1-54a772b48ff6
# ╠═e12751b3-0c8d-4655-b606-ae94d670b0d0
# ╟─abe64b2a-f192-4e3b-ba3e-f26286b1a38d
# ╟─0c3fcf92-8924-49ac-b487-a9dc372b2739
# ╠═98b06ba3-7f03-4649-9627-33c6c7108141
# ╠═2d59475e-728c-47ef-8e1c-13750857f6f8
# ╠═25c72bf7-28ce-4f6b-b4c4-24be2f51a5f9
# ╠═3595a191-495f-4263-8312-09e5d9c3d252
# ╠═13980acc-8aa1-4d87-ab7e-c1a599e0483d
# ╟─f83180f3-157c-4f6c-9ed5-e41bf58ecc6d
# ╠═38fcc0c0-aaaa-4777-b67c-9cc5c9289a91
# ╠═7ac69279-0c12-45e5-ae6d-3a5ffa199dec
# ╠═9a61b3d7-3a77-417d-b60b-7172050167e4
# ╠═63eb66c8-01eb-4e5b-bb3e-469de4eb0697
# ╠═e6f38a8d-3db9-47ed-801e-2f434d2ef70c
# ╠═a66db96a-a6f1-4628-8a89-d8b2744eb3b5
# ╠═9179ea73-224c-4291-8cc5-4617524a0b81
# ╟─6f574b34-0f78-4b61-bac0-047eaad04e9c
# ╠═0a63424d-ab08-4dd4-bff8-5239ec312733
# ╠═dc7c0906-269b-4f7f-ba11-f6ba4c4b40d6
# ╠═a546c9bc-7d20-4636-850f-f900194e97e8
# ╠═bd81f1da-ac98-493f-8bc2-d5b1fa635473
# ╠═9aff572e-683c-4085-878f-8c87c046db6f
# ╠═c14d0c51-164b-41a2-a6df-befd3faf47f2
# ╠═21cb4890-628a-4331-a163-77fd8b3c9e05
# ╠═526287c9-8d28-4357-8313-6f7ba2f2f49b
# ╠═312a0197-d66c-436d-9452-7c70e4cfaded
# ╠═483422b0-666b-4600-a96b-9dd84ca19298
# ╠═ee40ceea-7d3f-4578-902d-d1518f4c7c84
# ╠═e12d35e5-4ea6-42f4-a396-92e4d4ebc5c7
# ╠═3947a6c1-4bbe-4ee0-a3e6-114e481dc49c
# ╠═c0246b4f-134b-4413-9cae-f8dd1d4986b7
# ╠═b0f62fbd-a577-45a0-be31-aab76babb417
# ╠═cf728878-fefb-4d46-a52e-1d0820248d35
# ╠═01db2622-4b44-492d-a0f6-838018727e75
# ╠═8dcce330-fad7-4dde-86c9-f3c732089278
# ╠═55151c58-ce42-4473-8bee-6ae501b5a891
# ╠═f2ac7e44-7a07-4956-9f22-526af10d1fe0
# ╠═1fcb8085-02f2-4907-999a-19db73ce4563
# ╠═9ceb6a8a-9235-49af-94ae-aa762e96aff0
# ╠═7bad9eb6-9201-4642-b147-193fbb5702fd
# ╠═ab183ae7-8e20-4413-b4f4-68000038974c
