return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = true,
                styles = {
                    floats = "transparent",
                    sidebars = "transparent",
                },
                on_colors = function (colors)
                    colors.bg_statusline = colors.none
                end
            })
            vim.cmd [[colorscheme tokyonight]]
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        -- event = "VeryLazy",
        enabled = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                auto_integrations = true,
            })
            vim.cmd.colorscheme("catppuccin-mocha")
        end
    },
}
