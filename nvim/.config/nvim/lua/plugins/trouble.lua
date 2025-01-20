return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  keys = {
    { "<leader>tx", "<cmd>TroubleToggle<CR>",                       desc = "Diagnostics" },
    { "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace diagnostics" },
    { "<leader>td", "<cmd>TroubleToggle document_diagnostics<CR>",  desc = "File diagnostics" },
    { "<leader>tq", "<cmd>TroubleToggle quickfix<CR>",              desc = "Quick fix list" },
    { "<leader>tl", "<cmd>TroubleToggle loclist<CR>",               desc = "Trouble location list" },
    { "<leader>tl", "<cmd>TroubleToggle loclist<CR>",               desc = "Trouble location list" },
  }
}
