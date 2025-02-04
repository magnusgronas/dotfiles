return {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	keys = {
		{ "<leader>tx", "<cmd>Trouble<CR>", desc = "Diagnostics" },
		{ "<leader>tw", "<cmd>Trouble workspace_diagnostics<CR>", desc = "Workspace diagnostics" },
		{ "<leader>td", "<cmd>Trouble document_diagnostics<CR>", desc = "File diagnostics" },
		{ "<leader>tq", "<cmd>Trouble quickfix<CR>", desc = "Quick fix list" },
		{ "<leader>tl", "<cmd>Trouble loclist<CR>", desc = "Trouble location list" },
		{ "<leader>tl", "<cmd>Trouble loclist<CR>", desc = "Trouble location list" },
	},
}
