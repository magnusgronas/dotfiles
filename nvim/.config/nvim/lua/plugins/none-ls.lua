return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    require("mason-null-ls").setup({
      ensure_installed = {
        "prettierd",
        "stylua",
        "eslint_d",
        "shfmt",
        "csharpier",
        "google-java-format",
      },
      -- auto-install configured formatters & linters (with null-ls)
      automatic_installation = true,
    })

    vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, { desc = "Format file" })

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup({

      sources = {
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        require("none-ls.diagnostics.eslint"),
        null_ls.builtins.formatting.csharpier,
        null_ls.builtins.formatting.google_java_format,
      },

      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
