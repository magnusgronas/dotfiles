return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local hide = function()
			return vim.fn.winwidth(0) > 100
		end

		require("lualine").setup({

			options = {
				disabled_filetypes = { "snacks_dashboard" },
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
						color = { fg = "#6e738d" },
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
					"diagnostics",
				},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
