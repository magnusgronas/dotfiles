return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile"},
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {},
  keys = {
    { "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Find Todos"},
    { "øt", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment"},
    { "æt", function() require("todo-comments").jump_next() end, desc = "Next todo comment"},
    -- TODO: wow
  }
}
