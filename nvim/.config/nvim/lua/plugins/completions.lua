return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
			},
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			{
				"hrsh7th/cmp-cmdline",
				config = function()
					local cmp = require("cmp")
					cmp.setup.cmdline(":", {
						mapping = cmp.mapping.preset.cmdline(),
						sources = cmp.config.sources({
							{ name = "path" },
						}, {
							{
								name = "cmdline",
								option = {
									ignore_cmds = { "Man", "!" },
								},
							},
						}),
					})
				end,
			},
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				completion = {
					competeopt = "menu,menuone,preview,noselect",
				},

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				experimental = {
					ghost_text = true,
				},

				mapping = cmp.mapping.preset.insert({
					vim.api.nvim_set_keymap("i", "<C-k>", "", { noremap = true, silent = true }),
					vim.api.nvim_set_keymap("i", "<C-j>", "", { noremap = true, silent = true }),

					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "buffer" },
					{ name = "path" },
				}),

				---@diagnostic disable-next-line: missing-fields
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})

			local s = luasnip.snippet
			local t = luasnip.text_node
			local i = luasnip.insert_node

			luasnip.add_snippets("markdown", {
				s("eq", {
					t("$$"),
					i(1, "equation"),
					t("$$"),
				}),
			})

			-- Keymaps for jumping to next param in snippet
			vim.keymap.set({ "i", "s" }, "<C-l>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-h>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { silent = true })
		end,
	},
}
