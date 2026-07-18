return {
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            kotlin = { "ktlint" },
        }
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "InsertEnter" }, {
            group = vim.api.nvim_create_augroup("linter", { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
