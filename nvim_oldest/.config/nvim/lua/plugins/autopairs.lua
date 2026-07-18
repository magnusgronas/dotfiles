return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	config = function()
		-- Call the autopairs setup function to configure how we want autopairs to work
		require("nvim-autopairs").setup({
			check_ts = true,
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
				java = false,
			},
		})
	end,
}
