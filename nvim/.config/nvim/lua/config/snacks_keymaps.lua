-- Mapping function
local function map(lhs, rhs, opts, mode)
	local options = { noremap = true, silent = true }
	mode = mode or "n"
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- General mappings
map("<leader>ff", function()
	Snacks.picker.files({
		exclude = { "*.class", "target/**" },
	})
end, { desc = "Find Files" })

map("<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Grep Search" }, { "n", "v" })

map("<leader>fc", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config" })

map("<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent Files" })

map("<leader>:", function()
	Snacks.picker.command_history({ layout = { preset = "ivy", preview = false } })
end, { desc = "Command History" })

map("<leader>n", function()
	if Snacks.config.picker and Snacks.config.picker.enabled then
		Snacks.picker.notifications({ layout = { preset = "vscode" } })
	else
		Snacks.notifier.show_history()
	end
end, { desc = "Notification History" })

map("<leader>fd", function()
	Snacks.picker.diagnostics({ style = "dropdown" })
end, { desc = "Diagnostics" })

-- LSP mappings

map("gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto definition" })

map("gD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "Goto declaration" })

map("gr", function()
	Snacks.picker.lsp_references()
end, { desc = "Goto references", nowait = true })

map("gi", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Goto implementations" })

map("gy", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Goto type definition" })

map("<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { desc = "LSP symbols" })

map("<leader>sS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP symbols" })
