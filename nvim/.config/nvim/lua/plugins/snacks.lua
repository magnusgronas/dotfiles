return {
	"folke/snacks.nvim",
	priority = 1000,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	keys = {
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
	},
	opts = {
		notifier = {
			enabled = true,
			style = "compact",
		},
		dashboard = {
			width = 40,
			preset = {
				keys = {
					{
						icon = "  >",
						desc = "New File",
						key = "n",
						action = ":ene | startinsert",
					},
					{
						icon = "  >",
						desc = "Find Files",
						key = "f",
						action = ":lua Snacks.dashboard.pick('files')",
					},
					{
						icon = "  >",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = "  >",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{ icon = "  >", key = "d", desc = "Open direcoties", action = ":Oil --preview" },
					{
						icon = "  >",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = "󰒲  >",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = "  >", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		zen = {
			toggles = {
				dim = true,
				git_signs = false,
				mini_diff_signs = false,
				-- diagnostics = false,
				-- inlay_hints = false,
			},
			show = {
				statusline = false, -- can only be shown when using the global statusline
				tabline = false,
			},
			zoom = {
				toggles = {},
				show = { statusline = true, tabline = true },
				win = {
					backdrop = false,
					width = 0, -- full width
				},
			},
		},
	},
}
