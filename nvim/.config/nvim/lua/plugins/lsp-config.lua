return {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			"Saghen/blink.cmp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/lazydev.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")

			-- Create LSP attach autocmd
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local wk = require("which-key")
					wk.add({
						{ "K", vim.lsp.buf.hover, desc = "Show Hover Documentation" },
						{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
						{ "<leader>rn", vim.lsp.buf.rename, desc = "Lsp Rename" },
						{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Actions" },
					}, {
						mode = "n",
						buffer = ev.buf,
					})
				end,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["clangd"] = function()
					lspconfig["clangd"].setup({
						capabilities = capabilities,
						init_options = {
							fallbackFlags = { "-std=c++23" },
						},
					})
				end,
				["emmet_ls"] = function()
					lspconfig["emmet_ls"].setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescriptreact",
							"javascriptreact",
							"css",
							"sass",
							"scss",
							"less",
							"svelte",
						},
					})
				end,
				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,
			})
		end,
	},
}
