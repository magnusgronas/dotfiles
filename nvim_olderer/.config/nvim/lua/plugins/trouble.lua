return {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	opts = {
		focus = true,
	},
	cmd = "Trouble",
	keys = {
		{ "<leader>dt", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
		{ "<leader>dX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
		{ "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
		{ "<leader>dL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		{ "<leader>dQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
	},
}
