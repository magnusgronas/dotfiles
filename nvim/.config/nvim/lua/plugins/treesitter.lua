return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    ---@diagnostic disable-next-line: missing-fields
    treesitter.setup({
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "html",
        "java",
        "javascript",
        "json",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "regex",
        "vim",
        "vimdoc",
        vim.filetype.add({
          pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
        }),
      },
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
    })
  end,
}
