return {
	"nvim-treesitter/nvim-treesitter",
	-- event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		---@diagnostic disable-next-line: missing-fields
		treesitter.setup({
			ensure_installed = {
				"c",
				"cpp",
				"cs",
				"bash",
				"lua",
				"vim",
				"vimdoc",
				"javascript",
				"html",
				"css",
				"java",
				"json",
				"latex",
				"regex",
				"markdown",
				"markdown_inline",
				vim.filetype.add({
					pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
				}),
			},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true },
		})
	end,
}
