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

# ╔═╡ 62e31cae-8deb-49a5-a6a1-54a772b48ff6
md"""
## Initializing Data
"""

# ╔═╡ e12751b3-0c8d-4655-b606-ae94d670b0d0
begin
	D1= SeisParabEvents()
	D2= SeisLinearEvents()
	
	D = SeisAddNoise( D1 + 0.1*D2,2)
	nothing
end

# ╔═╡ 26992493-fe50-4f59-8141-9ea9e8606516


# ╔═╡ abe64b2a-f192-4e3b-ba3e-f26286b1a38d
md"""
## SeisWiggle
"""

# ╔═╡ c25286cd-82b5-4725-96cc-4ab6ed0aa121
begin
	f1, ax1 = SeisWiggle(D)
	f1
end

# ╔═╡ 25c72bf7-28ce-4f6b-b4c4-24be2f51a5f9
begin
	function start_and_interval()
		ox, dx = 1000, 3
		oy, dy = 500, 5
		f, ax = SeisWiggle(D, ox=ox, dx=dx, oy=oy, dy=dy)
		f
	end
	start_and_interval()
end

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
	
		f, ax = SeisWiggle(d, gx=gx)
		f
	end
	real_coords()
end

# ╔═╡ 38fcc0c0-aaaa-4777-b67c-9cc5c9289a91
begin
	function excursion()
		f, ax = SeisWiggle(D, xcur=5)
		f
	end
	excursion()
end

# ╔═╡ 9a61b3d7-3a77-417d-b60b-7172050167e4
begin
	function trace_increment()
		f, ax = SeisWiggle(D, wiggle_trace_increment=4)
		f
	end
	trace_increment()
end

# ╔═╡ e6f38a8d-3db9-47ed-801e-2f434d2ef70c
begin
	function formatting()
		f, ax = SeisWiggle(D, wiggle_trace_increment=4, wiggle_line_color=:orange, wiggle_fill_color=:purple)
		f
	end
	formatting()
end

# ╔═╡ a66db96a-a6f1-4628-8a89-d8b2744eb3b5
md"""
## SeisColor
"""

# ╔═╡ 0a63424d-ab08-4dd4-bff8-5239ec312733
begin
	function base_color()
		f, ax = SeisColor(D)
		f
	end
	base_color()
end

# ╔═╡ a546c9bc-7d20-4636-850f-f900194e97e8
begin
	function with_pclip()
		f, ax = SeisColor(D, pclip=95)
		f
	end
	dx = 1
	with_pclip()
end

# ╔═╡ 9aff572e-683c-4085-878f-8c87c046db6f
begin
	function with_vmin_vmax()
		f, ax = SeisColor(D, vmin=-0.1, vmax=0.4)
		f
	end
	with_vmin_vmax()
end

# ╔═╡ 21cb4890-628a-4331-a163-77fd8b3c9e05
begin
	function with_different_colormap()
		f, ax = SeisColor(D, colormap=:seismic)
		f
	end
	with_different_colormap()
end

# ╔═╡ 526287c9-8d28-4357-8313-6f7ba2f2f49b
md"""
## SeisOverlay
You can use a combination of the arguments supplied to SeisWiggle and SeisColor
"""

# ╔═╡ 312a0197-d66c-436d-9452-7c70e4cfaded
begin
	function base_overlay()
		f, ax = SeisOverlay(D)
		f
	end
	base_overlay()
end

# ╔═╡ 483422b0-666b-4600-a96b-9dd84ca19298
begin
	function overlay_with_args()
		f, ax = SeisOverlay(D, ox=20, dx=10, oy=500, dy=3, colormap=:seismic, vmin=-0.2, vmax=0.3)
		f
	end
	overlay_with_args()
end

# ╔═╡ 2b231e00-8952-4bfc-b26e-79abcc6258e9
md"""
## SeisPlotTX
Based on request. Pass in the arguments you want along with a `style` keyword. `style` can be one of "wiggle", "overlay", "color".
"""

# ╔═╡ 6ccaf31a-caa8-4118-861d-9dd960b28d73
begin 
	function seisplottx_demo()
		f, ax = SeisPlotTX(D, style="overlay")
		f
	end
	seisplottx_demo()
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
		f, ax = SeisOverlay(D, pclip=97)
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
		_, wiggle_ax = SeisWiggle(D, fig=f[1,1], wiggle_trace_increment=4)
		_, color_ax = SeisColor(D, fig=f[2, 1])
		_, overlay_ax = SeisOverlay(D, fig=f[1,2], wiggle_trace_increment=4)

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

# ╔═╡ f2ac7e44-7a07-4956-9f22-526af10d1fe0


# ╔═╡ 1fcb8085-02f2-4907-999a-19db73ce4563


# ╔═╡ Cell order:
# ╠═93296b66-bca6-11ee-0787-99798c15a928
# ╠═90077fbb-2384-4d12-b51a-f52758049e49
# ╠═62e31cae-8deb-49a5-a6a1-54a772b48ff6
# ╠═e12751b3-0c8d-4655-b606-ae94d670b0d0
# ╠═26992493-fe50-4f59-8141-9ea9e8606516
# ╠═abe64b2a-f192-4e3b-ba3e-f26286b1a38d
# ╠═c25286cd-82b5-4725-96cc-4ab6ed0aa121
# ╠═25c72bf7-28ce-4f6b-b4c4-24be2f51a5f9
# ╠═13980acc-8aa1-4d87-ab7e-c1a599e0483d
# ╠═38fcc0c0-aaaa-4777-b67c-9cc5c9289a91
# ╠═9a61b3d7-3a77-417d-b60b-7172050167e4
# ╠═e6f38a8d-3db9-47ed-801e-2f434d2ef70c
# ╠═a66db96a-a6f1-4628-8a89-d8b2744eb3b5
# ╠═0a63424d-ab08-4dd4-bff8-5239ec312733
# ╠═a546c9bc-7d20-4636-850f-f900194e97e8
# ╠═9aff572e-683c-4085-878f-8c87c046db6f
# ╠═21cb4890-628a-4331-a163-77fd8b3c9e05
# ╠═526287c9-8d28-4357-8313-6f7ba2f2f49b
# ╠═312a0197-d66c-436d-9452-7c70e4cfaded
# ╠═483422b0-666b-4600-a96b-9dd84ca19298
# ╠═2b231e00-8952-4bfc-b26e-79abcc6258e9
# ╠═6ccaf31a-caa8-4118-861d-9dd960b28d73
# ╠═ee40ceea-7d3f-4578-902d-d1518f4c7c84
# ╠═e12d35e5-4ea6-42f4-a396-92e4d4ebc5c7
# ╠═3947a6c1-4bbe-4ee0-a3e6-114e481dc49c
# ╠═c0246b4f-134b-4413-9cae-f8dd1d4986b7
# ╠═b0f62fbd-a577-45a0-be31-aab76babb417
# ╠═cf728878-fefb-4d46-a52e-1d0820248d35
# ╠═01db2622-4b44-492d-a0f6-838018727e75
# ╠═8dcce330-fad7-4dde-86c9-f3c732089278
# ╠═f2ac7e44-7a07-4956-9f22-526af10d1fe0
# ╠═1fcb8085-02f2-4907-999a-19db73ce4563
