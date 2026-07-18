return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
	{
		"elmcgill/springboot-nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-jdtls",
		},
		ft = "java",
		config = function()
			local springboot_nvim = require("springboot-nvim")

			local keymap = vim.keymap.set

			keymap("n", "<leader>jr", springboot_nvim.boot_run, { desc = "Java Run Springboot" })
			keymap("n", "<leader>jc", springboot_nvim.generate_class, { desc = "Java Create Class" })
			keymap("n", "<leader>ji", springboot_nvim.generate_interface, { desc = "Java Create Interface" })
			keymap("n", "<leader>je", springboot_nvim.generate_enum, { desc = "Java Create Enum" })
			keymap("n", "<leader>jo", springboot_nvim.generate_record, { desc = "Java Create Record" })

			springboot_nvim.setup()
		end,
	},
}
