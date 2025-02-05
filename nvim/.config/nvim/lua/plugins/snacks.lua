return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		animate = {
			enabled = true,
			fps = 120,
		},

		bigfile = { enabled = true },

		dashboard = { enabled = false },

		indent = {
			indent = {
				priority = 1,
				enabled = true, -- enable indent guides
				char = "│",
				only_scope = false, -- only show indent guides of the scope
				only_current = false, -- only show indent guides in the current window
				hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
			},
			animate = { enabled = false },
			scope = {
				enabled = false, -- enable highlighting the current scope },
			},

			input = {
				enabled = true,
				icon = " ",
				icon_hl = "SnacksInputIcon",
				icon_pos = "left",
				prompt_pos = "title",
				win = { style = "input" },
				expand = true,
			},
			picker = { enabled = false },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
	},
}
