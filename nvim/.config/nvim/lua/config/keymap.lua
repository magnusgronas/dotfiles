vim.g.mapleader = " "

local map = function(lhs, rhs, opts, mode)
  local options = { noremap = true, silent = true }
  mode = mode or "n"
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- disable spaces default behaviour
map("<Space>", "<Nop>", {}, { "n", "v" })

-- disable highlighting with ESC
map("<ESC>", "<cmd>noh<CR>")

-- move normally on wrapped lines
map("j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
map("k", "v:count == 0 ? 'gk' : 'k'", {expr = true})

-- delete single character without copying into register
map("x", '"_x')

-- nake $ more accessible
map("¤", "$", {}, { "n", "v" })

-- add line above and below without entering instert mode
map("<C-CR>", ":put _<CR>")
map("<S-CR>", ":put! _<CR>")

-- vertical scroll and center
map("<C-d>", "<C-d>zz")
map("<C-u>", "<C-u>zz")

-- find and center
map("n", "nzzzv")
map("N", "Nzzzv")

map("<C-j>", "<C-w>j")
map("<C-k>", "<C-w>k")
map("<C-h>", "<C-w>h")
map("<C-l>", "<C-w>l")

-- resize with arrows
map("<Up>", ":resize -2<CR>")
map("<Down>", ":resize +2<CR>")
map("<Left>", ":vertical resize -2<CR>")
map("<Right>", ":vertical resize +2<CR>")

-- buffers
map("<Tab>", ":bnext<CR>")
map("<S-Tab>", ":bprevious<CR>")
map("<leader>x", ":bdelete<CR>", { desc = "Close buffer" })
map("<leader>n", ":enew<CR>", { desc = "Open new buffer" })

-- window management
map("<leader>sv", "<C-w>v", { desc = "Vertical split" })
map("<leader>sh", "<C-w>s", { desc = "Horizontal split" })
map("<leader>se", "<C-w>=", { desc = "Make splits equal" })
map("<leader>sx", ":close<CR>", { desc = "Close split" })

-- stay in indent mode
map("<", "<gv", {}, { "v" })
map(">", ">gv", {}, { "v" })

-- keep last yanked when pasting
map("p", '"_dP', {}, { "v" })

-- substitute word under cursor
map("<leader>sb", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor" })

-- make script executable
map("<leader>Ex", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })

-- diagnostic keymaps
map("gl", function ()
  vim.diagnostic.open_float()
end, {desc = "Open diagnostic in float"})

-- native undotree
map("<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, { desc = "Toggle undotree" })
