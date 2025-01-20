return {
	{
		"nvim-java/nvim-java",
		event = "VeryLazy",
		config = function()
			require("java").setup({})
		end,
	},
	{
		"williamboman/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "java-debug-adapter", "java-test", "codelldb" },
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
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
					ensure_installed = {
						"clangd",
						"clang-format",
						"codelldb",
					},
				})
				mason_lspconfig.setup({
					ensure_installed = {
						"ts_ls",
						"html",
						"cssls",
						"clangd",
						"lua_ls",
						"emmet_ls",
						"hyprls",
						"biome",
						"jdtls",
					},
					automatic_installation = true,
				})
			end,
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/lazydev.nvim", opts = {} },
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")

			local lspconfig = require("lspconfig")

			local telescope = require("telescope.builtin")

			local keymap = vim.keymap.set

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					-- LSP keymaps
					keymap("n", "K", vim.lsp.buf.hover, opts)
					keymap("n", "gd", vim.lsp.buf.definition, opts)
					keymap("n", "gD", vim.lsp.buf.declaration, opts)
					opts.desc = "Lsp rename"
					keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
					opts.desc = "Code actions"
					keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

					opts.desc = "Lsp references"
					keymap("n", "<leader>cr", telescope.lsp_references, opts)
					opts.desc = "Lsp implementations"
					keymap("n", "<leader>ci", telescope.lsp_implementations, opts)
				end,
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
							lua = {
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
			-- Use an autocommand to detect when jdtls attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client_id = args.data.client_id
					local client = vim.lsp.get_client_by_id(client_id)

					-- Check if the attached LSP client is jdtls
					if client.name == "jdtls" then
						local buf = vim.api.nvim_get_current_buf()

						local springboot_nvim = require("springboot-nvim")

						vim.keymap.set(
							"n",
							"<leader>jr",
							springboot_nvim.boot_run,
							{ desc = "Run Spring Boot", buffer = buf }
						)
						vim.keymap.set(
							"n",
							"<leader>jc",
							springboot_nvim.generate_class,
							{ desc = "New class", buffer = buf }
						)
						vim.keymap.set(
							"n",
							"<leader>ji",
							springboot_nvim.generate_interface,
							{ desc = "New interface", buffer = buf }
						)
						vim.keymap.set(
							"n",
							"<leader>je",
							springboot_nvim.generate_enum,
							{ desc = "New enum", buffer = buf }
						)

						vim.keymap.set("n", "<leader>jo", function()
							vim.lsp.buf.code_action({
								context = { only = { "source.organizeImports" } },
								apply = true,
							})
						end, { desc = "Organize imports" })

						vim.keymap.set("n", "<leader>jg", function()
							vim.lsp.buf.code_action({
								context = { only = { "source.generate" } },
							})
						end, { desc = "Generate" })
					end
				end,
			})
		end,
	},
}
