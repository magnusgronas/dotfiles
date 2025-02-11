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
			enabled = true,
			style = "compact",
		},
		dashboard = {
			enabled = true,
			width = 80,
			preset = {
				header = [[]],
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
			sections = {
				{
					pane = 2,
					{ icon = " ", title = "Keymaps", section = "keys", width = 50, indent = 2, padding = 1 },
					{
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git --no-pager diff --stat -B -M -C",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
					},
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ section = "startup" },
				},
				{
					section = "terminal",
					cmd = "chafa ~/Pictures/wallpaper/marine-tunnel.jpg --format symbols --symbols vhalf --size 80x20 --stretch; sleep .1",
					height = 20,
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
	config = true,
	keys = {
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Enable Zen Mode",
		},
	},
}
