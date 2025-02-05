return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		-- local themes = require("telescope.themes")

		telescope.setup({
			-- pickers = {
			-- 	find_files = {
			-- 		theme = "ivy",
			-- 	},
			-- },
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<c-k>"] = actions.move_selection_previous,
						["<c-j>"] = actions.move_selection_next,
						["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
			},
			extensions = {
				fzf = {},
			},
		})

		telescope.load_extension("fzf")

		local keymap = vim.keymap.set
		keymap("n", "<leader>ff", builtin.find_files, { desc = "search for files" })
		keymap("n", "<leader>fg", builtin.live_grep, { desc = "grep search" })
		keymap({ "n", "v" }, "<leader>fs", builtin.grep_string, { desc = "search for string under cursor" })
		keymap("n", "<leader>fd", builtin.diagnostics, { desc = "open diagnostics" })
		keymap("n", "<leader>fr", builtin.resume, { desc = "open previous search" })
		keymap("n", "<leader>f.", builtin.oldfiles, { desc = "open previous files" })
		keymap("n", "<leader>fb", builtin.buffers, { desc = "find buffers" })
		keymap("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "find todos" })
		keymap("n", "<leader>fh", builtin.help_tags, { desc = "find help" })
		keymap("n", "<leader>fp", builtin.builtin, { desc = "find telescope pickers" })
		keymap("n", "<leader>fn", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end, { desc = "nvim config" })
		keymap("n", "<leader>fl", function()
			builtin.find_files({
				cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
			})
		end, { desc = "find plugins" })
	end,
}
