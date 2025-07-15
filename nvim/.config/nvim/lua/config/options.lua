local opt = vim.opt
local indent = 4

-- appearance and misc
opt.nu = true
opt.relativenumber = true
opt.termguicolors = true
opt.background = "dark"
opt.scrolloff = 999
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.fillchars = { eob = " " }
opt.cmdheight = 1
opt.laststatus = 3
opt.ruler = false
-- opt.winborder = "rounded"

-- HACK: hide cursor line but still highlight current linenumber
opt.cursorline = true
vim.cmd("highlight CursorLine ctermbg=235 guibg=NONE")

-- tab / indenting
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

-- general behaviour
opt.conceallevel = 0
opt.mouse = "a"
opt.showmode = false
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 1000
opt.writebackup = false
opt.endofline = true
opt.fixendofline = true
vim.g.editorconfig = true
opt.updatetime = 50
opt.clipboard:append("unnamedplus")
opt.clipboard:append("unnamed")
opt.backspace = "indent,eol,start"
opt.encoding = "UTF-8"

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split"
opt.ignorecase = true
opt.smartcase = true

local icons = require("util").icons

-- Diagnostics
vim.diagnostic.config({
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
  float = {
    border = "rounded",
    header = { icons.debug .. " Diagnostics:" },
  },
  virtual_text = {
    prefix = "●",
    source = "if_many",
    spacing = 8,
  },
})

-- Hover docs
