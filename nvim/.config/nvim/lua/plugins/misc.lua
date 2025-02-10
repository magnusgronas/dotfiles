return {
	-- {
	-- 	"norcalli/nvim-colorizer.lua",
	-- 	config = function()
	-- 		require("colorizer").setup()
	-- 	end,
	-- },
	-- {
	-- 	"stevearc/dressing.nvim",
	-- 	event = "VeryLazy",
	-- },
	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		version = "*",
		config = true,
	},
	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize split" },
		},
	},
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle undotree" },
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	---@module "ibl"
	-- 	---@type ibl.config
	-- 	opts = {
	-- 		indent = {
	-- 			char = "│",
	-- 		},
	-- 		scope = {
	-- 			enabled = false,
	-- 		},
	-- 	},
	-- },
}
