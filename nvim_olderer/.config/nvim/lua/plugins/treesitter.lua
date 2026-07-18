return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	---@class TSConfig
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"diff",
				"javascript",
				"json",
				"latex",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"ninja",
				"python",
				"rasi",
				"regex",
				"rst",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
				"tsx",
			},
			auto_install = true,
		})
	end,
}
