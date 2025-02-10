vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- dissable spaces default behavior
keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

local opts = { noremap = true, silent = true }

keymap("n", "<leader>pv", ":Oil --preview<CR>", { desc = "Open file explorer" })
-- delete single character without copying into register
keymap("n", "x", '"_x', opts)

-- Make $ more accessible
keymap({ "n", "v" }, "¤", "$", opts)

-- Add line above and below without entering inster mode
keymap("n", "<C-CR>", ":put _<CR>", opts)
keymap("n", "<S-CR>", ":put! _<CR>", opts)

-- Up and down Center
-- keymap("n", "j", "jzz", opts)
-- keymap("n", "k", "kzz", opts)

-- Vertical scroll and center
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Resize with arrows
keymap("n", "<Up>", ":resize -2<CR>", opts)
keymap("n", "<Down>", ":resize +2<CR>", opts)
keymap("n", "<Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)
keymap("n", "<leader>x", ":bd<CR>", { desc = "Close buffer" }) -- close buffer
keymap("n", "<leader>b", "<cmd> enew <CR>", { desc = "Open new buffer" }) -- new buffer

-- Window management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Vertical split" }) -- split window vertically
keymap("n", "<leader>sh", "<C-w>s", { desc = "Horizontal split" }) -- split window horizontally
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal" }) -- make split windows equal width & height
keymap("n", "<leader>sx", ":close<CR>", { desc = "Close split" }) -- close current split window

-- Navigate between splits
keymap("n", "<C-k>", ":wincmd k<CR>", opts)
keymap("n", "<C-j>", ":wincmd j<CR>", opts)
keymap("n", "<C-h>", ":wincmd h<CR>", opts)
keymap("n", "<C-l>", ":wincmd l<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Keep last yanked when pasting
keymap("v", "p", '"_dP', opts)

-- Diagnostic keymaps
keymap("n", "ød", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })
keymap("n", "æd", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })
-- keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
