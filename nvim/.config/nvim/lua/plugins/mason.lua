return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")

			mason.setup({
				ui = {
					icons = {
						package_installed = "",
						package_pending = ">",
						package_uninstalled = "",
					},
				},
				-- formatters and tools
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
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
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
