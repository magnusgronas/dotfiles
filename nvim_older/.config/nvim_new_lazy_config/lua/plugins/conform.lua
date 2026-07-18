return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true })
            end,
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            css = { "prettierd", "prettier", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            javascriptreact = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            scss = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            typescriptreact = { "prettierd", "prettier", stop_after_first = true },
            lua = { "stylua" },
            kotlin = { "ktlint" },
            python = { "ruff" },
            sh = { "shfmt" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
}
