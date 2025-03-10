return {
  "echasnovski/mini.ai",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  config = function()
    require("mini.ai").setup()
  end,
}
