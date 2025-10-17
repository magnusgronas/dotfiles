-- Leader keys, set in lazy.lua
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Mapping function
local map = require("util").map

-- Disable spaces default behaviour
map("<Space>", "<Nop>", {}, { "n", "v" })

-- Disable highlighting with ESC
map("<ESC>", "<cmd>noh<CR>")

-- Move normally on wrapped lines
map("j", "gj")
map("k", "gk")

-- delete single character without copying into register
map("x", '"_x')

-- Make $ more accessible
map("¤", "$", {}, { "n", "v" })

-- Add line above and below without entering inster mode
map("<C-CR>", ":put _<CR>")
map("<S-CR>", ":put! _<CR>")

-- Vertical scroll and center
map("<C-d>", "<C-d>zz")
map("<C-u>", "<C-u>zz")

-- Find and center
map("n", "nzzzv")
map("N", "Nzzzv")

-- Resize with arrows
map("<Up>", ":resize -2<CR>")
map("<Down>", ":resize +2<CR>")
map("<Left>", ":vertical resize -2<CR>")
map("<Right>", ":vertical resize +2<CR>")

-- Buffers
map("<Tab>", ":bnext<CR>")
map("<S-Tab>", ":bprevious<CR>")
map("<leader>x", function ()
    Snacks.bufdelete()
end, { desc = "Close buffer" })
map("<leader>n", "<cmd> enew <CR>", { desc = "Open new buffer" })

-- Window management
map("<leader>sv", "<C-w>v", { desc = "Vertical split" })
map("<leader>sh", "<C-w>s", { desc = "Horizontal split" })
map("<leader>se", "<C-w>=", { desc = "Make splits equal" })
map("<leader>sx", ":close<CR>", { desc = "Close split" })

-- Move splits
-- map("<C-S-k>", "<C-w>K")
-- map("<C-S-j>", "<C-w>J")
-- map("<C-S-h>", "<C-w>H")
-- map("<C-S-l>", "<C-w>L")

-- Stay in indent mode
map("<", "<gv", {}, { "v" })
map(">", ">gv", {}, { "v" })

-- Keep last yanked when pasting
map("p", '"_dP', {}, { "v" })

-- Substitute word under cursor
map("<leader>sb", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor" })

-- Make script executable
map("<leader>Ex", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })

-- Highlight yank
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#a6e3a1", fg = "#000000" })
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight text after yanking",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ higroup = "YankHighlight", timeout = 300 })
    end,
})

-- Diagnostic keymaps
map("ød", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

map("æd", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

map("<leader>df", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
