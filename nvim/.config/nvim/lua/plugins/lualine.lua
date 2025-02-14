return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local custom_catppuccin = require("lualine.themes.catppuccin")

		-- Custom colours
		custom_catppuccin.normal.b.fg = "#cdd6f4"
		custom_catppuccin.insert.b.fg = "#cdd6f4"
		custom_catppuccin.visual.b.fg = "#cdd6f4"
		custom_catppuccin.replace.b.fg = "#cdd6f4"
		custom_catppuccin.command.b.fg = "#cdd6f4"
		custom_catppuccin.inactive.b.fg = "#cdd6f4"

		custom_catppuccin.normal.c.fg = "#6c7086"
		custom_catppuccin.normal.c.bg = ""

		custom_catppuccin.inactive.c.bg = "#313244"
		custom_catppuccin.inactive.c.fg = "#b4befe"

		local lazy_status = require("lazy.status")

		local hide = function()
			return vim.fn.winwidth(0) > 100
		end

		require("lualine").setup({
			options = {
				theme = custom_catppuccin,
				component_separators = "",
				section_separators = { left = "" },
				disabled_filetypes = { "snacks_dashboard" },
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
