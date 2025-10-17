return {
    "stevearc/conform.nvim",
    enabled = false,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>cf",
            function()
                require("conform").format({ async = true })
            end,
            desc = "Format buffer",
        },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { "stylua" },
            css = { "prettierd" },
            cpp = { "clang-format" },
            scss = { "prettierd" },
            python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd" },
            jsonc = { "prettier" },
            yaml = { "prettierd" },
            bash = { "shfmt" },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500 },
        -- Customize formatters
        formatters = {
            shfmt = {
                prepend_args = { "-i", "4" },
            },
            ruff = {},
            prettier = {
                prepend_args = { "--tab-width", "4" }
            },
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
