-- Mapping function
local function map(lhs, rhs, mode, opts)
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
