vim.o.cmdheight = 0
vim.opt.fillchars = { eob = " " }
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { trail = "·" }
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"

vim.opt.pumborder = vim.o.winborder

vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "list:-1"
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.smartcase = true

vim.g.editorconfig = true
vim.opt.backup = false
vim.opt.fixendofline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.timeoutlen = 1000
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.writebackup = false

vim.opt.clipboard:append("unnamedplus", "unnamed")
vim.opt.isfname:append("@-@")
vim.opt.backspace = "indent,eol,start"
vim.opt.mouse = "a"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
