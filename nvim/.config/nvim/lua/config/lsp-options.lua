local map = require("util").map
-- Lsp mappings
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions and CodeLens setup on attach",
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf
    -- if client:supports_method("textDocument/semanticTokens") then
    -- 	client.server_capabilities.semanticTokensProvider = nil
    -- end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
    if client:supports_method("textDocument/codeLens") then
      vim.lsp.codelens.refresh({ bufnr = bufnr })
      map("<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
      map("<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })
    end
    map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
    map("<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
    -- map("gi", vim.lsp.buf.implementation, { desc = "Go to implementations" })
    map("gi", Snacks.picker.lsp_implementations, { desc = "Go to implementations" })
    -- map("gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    map("gd", Snacks.picker.lsp_definitions, { desc = "Go to definition" })
    -- map("gr", vim.lsp.buf.references, { desc = "Find references" })
    map("gr", Snacks.picker.lsp_references, { desc = "Find references" })
  end,
})

-- Refresh codelens if its supported
vim.api.nvim_create_autocmd({ "InsertLeave", "BufWrite" }, {
  callback = function(args)
    -- local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf
    -- if client:supports_method("textDocument/codeLens") then
    vim.lsp.codelens.refresh({ bufnr = bufnr })
    -- end
  end,
})
