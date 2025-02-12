return {
	toggles = {
		dim = true,
		git_signs = false,
	},
	win = {
		backdrop = {
			transparent = false,
			blend = 99,
		},
	},
	show = {
		statusline = false, -- can only be shown when using the global statusline
		tabline = false,
	},
	zoom = {
		toggles = {
			dim = true,
		},
		show = { statusline = true, tabline = true },
		win = {
			backdrop = false,
			width = 0, -- full width
		},
	},
}
