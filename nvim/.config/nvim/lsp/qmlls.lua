-- This overrides the 'cmd' property of the server configuration
vim.lsp.config('qmlls', {
    cmd = { "/usr/lib/qt6/bin/qmlls" },
})

-- Then enable it, which uses the default filetypes/root_dir provided by nvim-lspconfig
