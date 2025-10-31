return {
	"mason-org/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- NOTE: Add lsp servers to this table. They will be automatically enabled by mason-lspconfig
		ensure_installed = {
			"bashls",
			"clangd",
			"cmake",
			"cssls",
			"emmet_language_server",
			"glsl_analyzer",
			"html",
			"hyprls",
			"lua_ls",
			"pyright",
            "kotlin_lsp",
            "qmlls",
            "ts_ls",
		},
	},
	dependencies = {
		{
			"mason-org/mason.nvim",
			cmd = "Mason",
			opts = {
				ui = {
					icons = {
						package_installed = "",
						package_pending = "",
						package_uninstalled = "",
					},
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
		},
	},
}
