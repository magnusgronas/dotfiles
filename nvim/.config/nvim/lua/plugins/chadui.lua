return {
	"nvim-lua/plenary.nvim",
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		"nvchad/ui",
		priority = 999,
		config = function()
			require("nvchad")
		end,
	},

	{
		"nvchad/base46",
		priority = 998,
		lazy = true,
		build = function()
			require("base46").load_all_highlights()
		end,
	},
}
