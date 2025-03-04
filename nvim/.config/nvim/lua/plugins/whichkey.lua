return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local which_key = require("which-key")
		which_key.add({
			{ "<leader>f", group = "Find" },
			{ "<leader>s", group = "Splits" },
			{ "<leader>t", group = "Diagnostics" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>c", group = "Code" },
		})
	end,
}
