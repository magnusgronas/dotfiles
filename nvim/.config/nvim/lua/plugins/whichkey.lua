return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  ---@class wk.Opts
  opts = {
    spec = {
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find" },
      { "<leader>x", group = "Diagnotics", icon = "󱖫" },
      { "<leader>g", group = "Git" },
      { "<leader>r", group = "Rename" },
      { "<leader>s", group = "Splits", icon = "" },
      { "<leader>b", group = "Buffer" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
