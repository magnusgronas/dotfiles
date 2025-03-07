return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		notifier = {
			enabled = false,
			style = "fancy",
		},

		dashboard = require("plugins.snacks.dashboard"),
		zen = require("plugins.snacks.zen"),
		indent = require("plugins.snacks.indent"),
		picker = require("plugins.snacks.picker"),

		statuscolumn = {
			left = { "mark", "sign" }, -- priority of signs on the left (high to low)
			right = { "fold", "git" }, -- priority of signs on the right (high to low)
			folds = {
				open = false, -- show open fold icons
				git_hl = false, -- use Git Signs hl for fold icons
			},
			git = {
				-- patterns to match Git signs
				patterns = { "GitSign", "MiniDiffSign" },
			},
			refresh = 50, -- refresh at most every 50ms
		},
	},
	config = true,
	keys = {
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Enable Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Enable Zen Mode",
		},
	},
}
