return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local todo = require("todo-comments")

    local keymap = vim.keymap.set
    keymap("n", "æt", function()
      todo.jump_next()
    end, { desc = "Next todo comment" })

    keymap("n", "øt", function()
      todo.jump_prev()
    end, { desc = "Previous todo comment" })

    todo.setup()
  end,
}
