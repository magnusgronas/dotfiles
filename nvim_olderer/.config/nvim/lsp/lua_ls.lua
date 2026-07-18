return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- Let it know 'vim' is a global
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true), -- Crucial for vim.* APIs
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
			codeLens = {
				enable = true,
			},
		},
	},
}
