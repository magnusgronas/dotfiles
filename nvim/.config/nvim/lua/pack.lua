vim.pack.add({
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/FylerOrg/fyler.nvim",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/rachartier/tiny-cmdline.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/saghen/blink.indent",

    -- completions
    "https://github.com/saghen/blink.cmp",
    "https://github.com/saghen/blink.lib",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/xzbdmw/colorful-menu.nvim",

    -- lsp
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
})

require("tokyonight").setup({
    transparent = true,
    styles = {
        sidebars = "transparent",
        floats = "transparent",
    },
    on_colors = function(colors)
        colors.bg_statusline = colors.none
    end,
})

require("tiny-cmdline").setup({
    title = { enabled = true },
    position = { y = "30%" },
    native_types = {}
})

require('blink.indent').setup({
    scope = { enabled = false },
    static = { char = "│" }
})

local win_config = function()
    local has_statusline = vim.o.laststatus > 0
    local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
    return { anchor = 'SE', title = "", col = vim.o.columns, row = vim.o.lines - pad }
end

require("mini.notify").setup({
    window = {
        config = win_config,
        winblend = 100
    }
})

require("mini.input").setup()

require("mini.icons").setup()
require("mini.surround").setup()
-- require("mini.indentscope").setup()
require("mini.pairs").setup()
-- require("mini.statusline").setup()

local MiniPick = require("mini.pick")
local MiniExtra = require('mini.extra')

MiniPick.setup()
MiniExtra.setup()

vim.keymap.set("n", "<leader>ff", function() MiniPick.builtin.files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function() MiniPick.builtin.grep() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fc", function() MiniPick.builtin.files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Find neovim config" })
vim.keymap.set("n", "<leader>fM", function() MiniExtra.pickers.manpages() end, { desc = "Find man pages" })
vim.keymap.set("n", "<leader>fd", function() MiniExtra.pickers.diagnostic() end, { desc = "Find diagnostics" })

local fyler = require("fyler")
fyler.setup({
    integrations = { icon = 'mini_icons' },
    extensions = {
        git = {
            enabled = true,
            inline = false,
        }
    }
})
vim.keymap.set("n", "<leader>e", fyler.open, { desc = "File explorer" })

require("plugins.blink")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.lualine")
