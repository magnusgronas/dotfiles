return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-mini/mini.icons" },
	config = function()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()

		local colors = require("tokyonight.colors").setup()
		local col_utils = require("tokyonight.util")
		local hide = function()
			return vim.fn.winwidth(0) > 80
		end
        local hide_lsp = function ()
            return vim.fn.winwidth(0) > 100
        end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "tokyonight",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "oil" },
					winbar = {},
				},
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = { left = "", right = "" },
					},
				},
				lualine_b = {
					{
						"filename",
						symbols = {
							modified = "",
							readonly = "",
							newfile = "󰝒",
						},
						separator = { right = "" },
					},
				},
				lualine_c = {
					{
						"branch",
						icon = "󰘬",
						color = { fg = col_utils.brighten(colors.fg_dark, -0.2, 0) },
                        cond = hide
					},
					{
						"diff",
						symbols = { added = "", modified = "~", removed = "" },
						diff_color = {
							added = { fg = colors.green },
							modified = { fg = colors.orange },
							removed = { fg = colors.red },
						},
                        cond = hide
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " " },
						diagnostics_color = {
							color_error = { fg = colors.red },
							color_warn = { fg = colors.yellow },
							color_info = { fg = colors.cyan },
						},
                        cond = hide
					},
				},
				lualine_x = {
					{
					    "fileformat",
                        cond = hide
					},
					{
						"filetype",
						icon_only = true,
                        cond = hide
					},
					{
						"lsp_status",
						color = { fg = col_utils.brighten(colors.fg_dark, -0.2, 0) },
                        cond = hide_lsp
					},
				},
				lualine_y = {},
				lualine_z = {
					{
						"progress",
						separator = { left = "" },
					},
					{
						"location",
						separator = { right = "" },
					},
				},
			},
		})
	end,
}
