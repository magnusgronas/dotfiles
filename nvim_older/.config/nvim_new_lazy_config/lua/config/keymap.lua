local map = function(lhs, rhs, opts, mode)
  local options = { noremap = true, silent = true }
  mode = mode or "n"
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Disable spaces default behaviour
map("<Space>", "<Nop>", {}, { "n", "v" })

-- Disable highlighting with ESC
map("<ESC>", "<cmd>noh<CR>")

-- Move normally on wrapped lines
map("j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
map("k", "v:count == 0 ? 'gk' : 'k'", {expr = true})

-- delete single character without copying into register
map("x", '"_x')

-- Make $ more accessible
map("¤", "$", {}, { "n", "v" })

-- Add line above and below without entering instert mode
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
map("<leader>x", function()
  Snacks.bufdelete()
end, { desc = "Close buffer" })
map("<leader>n", "<cmd> enew <CR>", { desc = "Open new buffer" })

-- Window management
map("<leader>sv", "<C-w>v", { desc = "Vertical split" })
map("<leader>sh", "<C-w>s", { desc = "Horizontal split" })
map("<leader>se", "<C-w>=", { desc = "Make splits equal" })
map("<leader>sx", ":close<CR>", { desc = "Close split" })

-- Stay in indent mode
map("<", "<gv", {}, { "v" })
map(">", ">gv", {}, { "v" })

-- Keep last yanked when pasting
map("p", '"_dP', {}, { "v" })

-- Substitute word under cursor
map("<leader>sb", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor" })

-- Make script executable
map("<leader>Ex", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })

-- map("<C-k>", "<C-w>k")
-- map("<C-j>", "<C-w>j")
-- map("<C-h>", "<C-w>h")
-- map("<C-l>", "<C-w>l")

-- Lsp keymaps
-- format keymap <leader>cf located in conform.lua

-- Diagnostic keymaps
map("gl", function ()
  vim.diagnostic.open_float()
end, {desc = "Open diagnostic in float"})
