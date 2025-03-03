return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			event = "VeryLazy",
		},

		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			mason.setup({
				ui = {
					icons = {
						package_installed = "",
						package_pending = "",
						package_uninstalled = "",
					},
				},
				-- formatters
				ensure_installed = {
					"clang-format",
					"codelldb",
				},
			})
			mason_lspconfig.setup({
				-- lsp servers
				ensure_installed = {
					"clangd",
					"csharp_ls",
					"cssls",
					"emmet_ls",
					"html",
					"hyprls",
					"jdtls",
					"lua_ls",
					"ts_ls",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"williamboman/mason-nvim-dap.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason-nvim-dap").setup({
				-- debug adapters
				ensure_installed = {
					"java-debug-adapter",
					"java-test",
				},
				automatic_installation = false,
			})
		end,
	},
}
