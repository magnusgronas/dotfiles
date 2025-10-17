return {
    {
        "folke/tokyonight.nvim",
        lazy = true,
        enabled = true,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = false,
                style = "night",
                styles = {
                    -- floats = "",
                    -- sidebars = "transparent",
                },
                cache = true,
                -- on_colors = function(colors)
                --     colors.bg_statusline = colors.none
                -- end,
                plugins = {
                    auto = true,
                }
            })
            vim.cmd [[colorscheme tokyonight]]
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
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
