return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {
    modes = {
      lsp = {
        win = { position = "right" },
      },
    },
  },
  keys = {
    { "<leader>tx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
    { "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>ts", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols (Trouble)" },
    {
      "<leader>tS",
      "<cmd>Trouble lsp toggle<cr>",
      desc = "LSP references/definitions/... (Trouble)",
    },
    { "<leader>tL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>tQ", "<cmd>Trouble qflist toggle<cr>",  desc = "Quickfix List (Trouble)" },
  },
}
