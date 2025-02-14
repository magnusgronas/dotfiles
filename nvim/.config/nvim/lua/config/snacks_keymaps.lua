-- Mapping function
local function map(lhs, rhs, opts, mode)
	local options = { noremap = true, silent = true }
	mode = mode or "n"
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

map("<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })

map("<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Grep Search" }, { "n", "v" })

map("<leader>fc", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config" })
