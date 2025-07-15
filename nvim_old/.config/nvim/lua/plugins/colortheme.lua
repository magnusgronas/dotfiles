return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				dap = true,
				dap_ui = true,
				gitsigns = true,
				mason = true,
				render_markdown = true,
				snacks = true,
				which_key = true,
				blink_cmp = true,
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
