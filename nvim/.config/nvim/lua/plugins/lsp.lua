return {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        -- NOTE: Add lsp servers to this table. They will be automatically enabled by mason-lspconfig
        ensure_installed = {
            "lua_ls",
            "clangd",
            "hyprls",
            "cmake",
            "bashls",
            "pyright",
            "cssls",
        },
    },
    dependencies = {
        {
            "mason-org/mason.nvim",
            cmd = "Mason",
            opts = {
                ui = {
                    icons = {
                        package_installed = "",
                        package_pending = "",
                        package_uninstalled = "",
                    },
                },
            },
        },
        {
            "neovim/nvim-lspconfig",
        },
    },
}
