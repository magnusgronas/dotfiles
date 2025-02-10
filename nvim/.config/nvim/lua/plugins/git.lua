return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({})

			vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { silent = true })
		end,
	},
}
