return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    -- enabled = false,
    dofile(vim.g.base46_cache .. "treesitter"),
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "python",
                "ninja",
                "rst",
                "rasi",
                "regex",
                "toml",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
            auto_install = true,
        })
    end
}
