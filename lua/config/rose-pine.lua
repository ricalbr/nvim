-- rose-pine config

local rosepine = require("rose-pine")
rosepine.setup({
	dark_variant = "moon",
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = false,
	disable_float_background = false,
	disable_italics = false,

	highlight_groups = {
		ColorColumn = { bg = "rose" },
		Normal = { bg = "none" },
		SignColumn = { bg = "none" },
		GitSignsAdd = { fg = "#68d98a" },
		GitSignsChange = { fg = "gold" },
		GitSignsDelete = { fg = "love" },
	},
})
