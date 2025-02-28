return {

	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"xzbdmw/colorful-menu.nvim",
		},

		version = "*",
		Event = "InsertEnter",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = {
				preset = "default",
				["<Tab>"] = { "select_and_accept", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-c>"] = { "cancel", "fallback" },
				["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h>"] = { "snippet_backward", "fallback" },
			},

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
				kind_icons = {
					Text = "",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",

					Field = "󰜢",
					Variable = "󰀫",
					Property = "󰜢",

					Class = "󰠱",
					Interface = "",
					Struct = "󰙅",
					Module = "",

					Unit = "",
					Value = "󰎠",
					Enum = "",
					EnumMember = "",

					Keyword = "󰌋",
					Constant = "󰏿",

					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "",
					TypeParameter = "",

					Table = "",
					Object = "󰅩",
					Tag = "",
					Array = "[]",
					Boolean = "",
					Number = "",
					Null = "󰟢",
					String = "󰉿",
				},
			},

			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				list = {
					selection = {
						preselect = true,
						auto_insert = true,
					},
				},
				menu = {
					scrollbar = false,
					border = "rounded",

					draw = {
						padding = 2,

						columns = {
							{ "kind_icon", "label", gap = 2 },
							{ gap = 2, "kind" },
						},
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
				documentation = {
					auto_show = true,
					window = {
						border = "rounded",
					},
				},
				ghost_text = {
					enabled = true,
					show_without_selection = true,
				},
			},

			fuzzy = {
				implementation = "rust",
			},

			signature = {
				enabled = true,
				trigger = {
					enabled = true,
					show_on_insert = true,
					show_on_keyword = true,
				},
				window = {
					border = "rounded",
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
