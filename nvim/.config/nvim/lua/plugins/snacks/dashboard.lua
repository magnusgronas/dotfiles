return {
	enabled = true,
	preset = {
		header = [[]],
		keys = {
			width = 40,
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
		},
		{
			section = "terminal",
			cmd = "chafa ~/Pictures/wallpaper/marine-tunnel.jpg --format symbols --symbols vhalf --size 60x15 --stretch; sleep .2",
			height = 15,
		},
		{ section = "startup", padding = { 0, 1, 0, 0 } },
	},
}
