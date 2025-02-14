return {
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
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			user_default_options = {
				virtualtext = "■",
				-- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
				virtualtext_inline = "before",
			},
		},
	},
}
