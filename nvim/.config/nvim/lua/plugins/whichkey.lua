return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
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
			{ "<leader>f", group = "find" },
			{ "<leader>s", group = "splits" },
			{ "<leader>t", group = "diagnostics" },
			{ "<leader>d", group = "debug" },
			{ "<leader>c", group = "code" },
		})
	end,
}
