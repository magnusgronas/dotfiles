return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			local mason = require("mason")

			mason.setup({
				ui = {
					icons = {
						package_installed = "",
						package_pending = "",
						package_uninstalled = "",
					},
				},
				-- formatters and tools
				ensure_installed = {
					"clang-format",
					"codelldb",
				},
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
