local M = {}

M.base46 = {
	theme = "catppuccin",
	hl_override = {
		St_LspHints = {
			fg = "#94E2D5",
		},
	},
}

M.ui = {
	statusline = {
		enabled = true,
		theme = "default",
		separator_style = "default",
		order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
	},
}

M.telescope = {}

return M
