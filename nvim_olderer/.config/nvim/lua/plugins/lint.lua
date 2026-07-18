return {
    "mfussenegger/nvim-lint",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        lint.linters_by_filetype = {
            -- python = { "ruff" },
            html = { "htmlhint" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" }
        }

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("lint", { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
