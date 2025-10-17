return {
    "nvimtools/none-ls.nvim",
    event = { "BufWritePre", "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
        "jayp0521/mason-null-ls.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("mason-null-ls").setup({
            ensure_installed = {
                "ruff",
                "prettierd",
                "stylua",
                "shfmt",
                "clang-format",
                -- "eslint_d",
            },
            automatic_installations = true,
        })
        -- TODO: DO STUFF

        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.shfmt.with({ args = { "-i", "4" } }),
                null_ls.builtins.formatting.prettierd.with({ args = { "--tab-width", "4" } }),
                null_ls.builtins.formatting.clang_format,
                require("none-ls.diagnostics.ruff"),
                require("none-ls.formatting.ruff_format"),
                -- require("none-ls.diagnostics.eslint_d"),
                -- require("none-ls.code_actions.eslint_d"),
            },
            -- NOTE: Auto Formatting function

            -- on_attach = function(client, bufnr)
            -- 	if client.supports_method("textDocument/formatting") then
            -- 		vim.api.nvim_create_autocmd("BufWritePre", {
            -- 			buffer = bufnr,
            -- 			callback = function()
            -- 				vim.lsp.buf.format({ async = true })
            -- 			end,
            -- 		})
            -- 	end
            -- end,
        })
        vim.keymap.set("n", "<leader>cf", function()
            vim.lsp.buf.format({ async = true })
        end, { desc = "Format buffer" })
    end,
}
