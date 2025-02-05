return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local custom_catppuccin = require("lualine.themes.catppuccin")

		-- Custom colours
		custom_catppuccin.normal.b.fg = "#cad3f5"
		custom_catppuccin.insert.b.fg = "#cad3f5"
		custom_catppuccin.visual.b.fg = "#cad3f5"
		custom_catppuccin.replace.b.fg = "#cad3f5"
		custom_catppuccin.command.b.fg = "#cad3f5"
		custom_catppuccin.inactive.b.fg = "#cad3f5"

		custom_catppuccin.normal.c.fg = "#6e738d"
		custom_catppuccin.normal.c.bg = ""

		custom_catppuccin.inactive.c.bg = "#363a4f"
		custom_catppuccin.inactive.c.fg = "#b7bdf8"

		local lazy_status = require("lazy.status")

		local hide = function()
			return vim.fn.winwidth(0) > 100
		end

		require("lualine").setup({
			options = {
				theme = custom_catppuccin,
				component_separators = "",
				section_separators = { left = "" },
				disabled_filetypes = { "alpha" },
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { right = "" } },
				},
				lualine_b = {
					{
						"filename",
						path = 4,
					},
				},
				lualine_c = {
					{
						"branch",
						icon = "",
						cond = hide,
					},
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						colored = false,
						cond = hide,
					},
				},
				lualine_x = {
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
					},
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
					},
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = "" },
						update_in_insert = true,
						cond = hide,
					},
					{
						lazy_status.updates,
						cond = lazy_status.has_updates or hide,
						color = { fg = "#f5a97f" },
					},
					"searchcount",
					{ "encoding", cond = hide },
				},
				lualine_y = {
					{
						"filetype",
						icon_only = true,
						separator = { left = "" },
					},
				},
				lualine_z = {
					{
						"progress",
						separator = { left = "" },
					},
					{
						"location",
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
