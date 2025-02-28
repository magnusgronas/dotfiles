return {
	priority = 1,
	enabled = true, -- enable indent guides
	-- char = "▎",
	char = "|",
	only_scope = false, -- only show indent guides of the scope
	only_current = false, -- only show indent guides in the current window
	hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
	animate = {
		enabled = false,
	},
	scope = {
		enabled = false,
	},
},
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			vim.defer_fn(function()
				vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#313244" })
			end, 50) -- Delay slightly to ensure it applies after Snacks
		end,
	})
