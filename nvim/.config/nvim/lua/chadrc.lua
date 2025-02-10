local M = {}

M.base46 = {
	theme = "catppuccin",
	-- changed_themes = {
	--   catppuccin = {
	--     base46
	--   }
	-- }
}

M.ui = {
	statusline = {
		enabled = true,
		theme = "default",
		separator_style = "default",
	},
}

M.lsp = {
	signature = true,
}

M.nvdash = {
	load_on_startup = false,
	buttons = {
		{ txt = "  New file", keys = "n", cmd = ":ene | startinsert" },
		{ txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
		{ txt = "  Recent Files", keys = "fr", cmd = "Telescope oldfiles" },
		{ txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
		{ txt = "󰒲  Lazy", keys = "L", cmd = ":Lazy" },
		{ txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
		{ txt = "  Quit", keys = "q", cmd = ":q!" },

		-- { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

		{
			txt = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime) .. " ms"
				return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
			end,
			hl = "NvDashFooter",
			no_gap = true,
		},

		-- { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
	},
}

M.telescope = {}

return M
