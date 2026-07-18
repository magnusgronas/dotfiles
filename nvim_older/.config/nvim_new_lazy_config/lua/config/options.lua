local opt = vim.opt
local indent = 4

-- Colorscheme
-- vim.cmd.colorscheme("tokyonight-night")
vim.cmd.colorscheme("tokyonight")

-- General behaviour
opt.mouse = "a"      -- enable mouse, placing cursor, rezising splits etc.
opt.swapfile = false -- disables the swapfile
opt.backup = false
opt.undofile = true
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 1000
opt.writebackup = false
opt.fixendofline = true
vim.g.editorconfig = true
opt.updatetime = 50
opt.clipboard:append("unnamedplus", "unnamed")
opt.backspace = "indent,eol,start"

-- Search
opt.inccommand = "split"
opt.ignorecase = true
opt.smartcase = true

-- Indenting / tab behaviour
opt.tabstop = indent -- indent width
opt.softtabstop = indent
opt.shiftwidth = indent
opt.expandtab = true -- replace tab character with spaces
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = "list:-1"

-- Appearance and misc
opt.nu = true
opt.relativenumber = true
opt.scrolloff = 999
opt.sidescrolloff = 8
opt.fillchars = { eob = " " }
opt.cmdheight = 1         -- 0 is experimental, could interfere with some messages
opt.laststatus = 3        -- Only one status line, stays at the bottom
opt.winborder = "rounded" -- the default style of borders for floating windows e.g. "none", "rounded", "single"
opt.pumborder = vim.o.winborder
opt.cursorline = true
opt.signcolumn = "yes"
opt.list = true
opt.listchars = { trail = "·" }

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
    update_in_insert = false,
    virtual_text = {
        enabled = true,
        prefix = "●",
        source = "if_many",
    },
})

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25"
vim.opt.completeopt = { "menuone", "noselect", "fuzzy", "popup" }
vim.opt.completeitemalign = { "kind", "abbr", "menu" }
