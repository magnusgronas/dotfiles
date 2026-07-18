return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "lua_ls",
            -- "ts_ls",
            "bashls",
            "pyright",
        },
    },
    dependencies = {
        { "neovim/nvim-lspconfig" },
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
    },
}
