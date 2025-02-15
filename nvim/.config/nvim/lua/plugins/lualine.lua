return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local lazy = require("lazy.status")

		local hide = function()
			return vim.fn.winwidth(0) > 100
		end

		-- Show currently attached lsp
		local lsp = function()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			if #clients == 0 then
				return ""
			end

			local client_names = {}
			for _, client in ipairs(clients) do
				table.insert(client_names, client.name)
			end

			if client_names[1] == "null-ls" then
				return client_names[2]
			end

			return client_names[1]
		end

		-- Color overrides
		local catppuccin = require("lualine.themes.catppuccin")

		-- Custom colors
		catppuccin.insert.a.fg = "#A6E3A1"
		catppuccin.insert.a.bg = "#1E1E2E"
		catppuccin.insert.a.gui = ""

		catppuccin.normal.a.fg = "#89B4FA"
		catppuccin.normal.a.bg = "#1E1E2E"
		catppuccin.normal.a.gui = ""

		catppuccin.visual.a.fg = "#A6E3A1"
		catppuccin.visual.a.bg = "#1E1E2E"
		catppuccin.visual.a.gui = ""

		catppuccin.command.a.fg = "#FAB387"
		catppuccin.command.a.bg = "#1E1E2E"
		catppuccin.command.a.gui = ""

		catppuccin.terminal.a.fg = "#F38BA8"
		catppuccin.terminal.a.bg = "#1E1E2E"
		catppuccin.terminal.a.gui = ""

		catppuccin.replace.a.fg = "#F38BA8"
		catppuccin.replace.a.bg = "#1E1E2E"
		catppuccin.replace.a.gui = ""

		require("lualine").setup({

			options = {
				disabled_filetypes = { "snacks_dashboard" },
				section_separators = "",
				component_separators = "",
				theme = catppuccin,
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{
						"filename",
						path = 4,
						symbols = {
							modified = "",
							readonly = "",
							unnamed = "[No Name]",
							newfile = "󰝒",
						},
					},
				},
				lualine_c = {
					{
						"branch",
						icon = "󰘬",
						color = { fg = "#6e738d", bg = "#1E1E2E" },
						cond = hide,
					},
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						diff_color = {
							added = "LualineDiff",
							modified = "LualineDiff",
							removed = "LualineDiff",
						},
						cond = hide,
					},
				},
				lualine_x = {
					{
						"diagnostics",
						update_in_insert = true,
						cond = hide,
					},
					{
						lazy.updates(),
						cond = lazy.has_updates() or hide(),
						color = { fg = "#fab387", bg = "#1E1E2E" },
					},
					{
						lsp,
						color = { fg = "#6e738d", bg = "#1E1E2E" },
					},
				},
				lualine_y = {
					{
						"filetype",
						icon_only = true,
					},
				},
				lualine_z = {
					"progress",
					"location",
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "progress", "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
