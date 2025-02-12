-- left column and similar settings
vim.wo.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.wo.signcolumn = "yes"
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 8
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#b7bdf8" })
vim.opt.cursorline = true
vim.cmd("highlight CursorLine ctermbg=235 guibg=NONE")
vim.opt.fillchars = { eob = " " }

-- tab spacing/behaviour
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.linebreak = true
vim.o.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
-- vim.o.linespace = 20
-- vim.o.numberwidth = 10

-- general behaviour
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.clipboard = "unnamedplus"
vim.opt.conceallevel = 0
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.timeoutlen = 1000
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.writebackup = false
vim.opt.endofline = true
vim.opt.fixendofline = true

-- Searching behaviour
vim.opt.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Change diagnostic icons

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
