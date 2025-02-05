return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		---@diagnostic disable-next-line: missing-fields
		treesitter.setup({
			ensure_installed = {
				"c",
				"cpp",
				"bash",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"javascript",
				"html",
				"java",
				"toml",
				"json",
				"latex",
				"regex",
				"markdown",
				"markdown_inline",
				"sql",
				vim.filetype.add({
					pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
				}),
			},
			auto_install = true,
			sync_install = false,
			-- highlight = { enable = true },
			indent = { enable = true },
			autotag = {
				enable = true,
			},
		})
	end,
}
