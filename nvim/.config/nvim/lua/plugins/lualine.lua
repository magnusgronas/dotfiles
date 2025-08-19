return {
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },

        config = function()
            local hide = function()
                return vim.fn.winwidth(0) > 80
            end

            require("lualine").setup({
                options = {
                    theme = "auto",
                    -- disabled_filetypes = { statusline = { "snacks_dashoard" } },
                    section_separators = {
                        left = "",
                        right = "",
                    },
                    component_separators = {
                        left = "",
                        right = "",
                    },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = {
                        {
                            "filename",
                            path = 4,
                            symbols = { modified = "", readonly = "", unnamed = "[No Name]", newfile = "󰝒", },
                        }
                    },
                    lualine_c = {
                        {
                            "branch",
                            icon = "󰘬",
                            color = { bg = "none" },
                            cond = hide,
                        },
                        {
                            'diff',
                            cond = hide,
                            color = { bg = "none" },
                        },
                    },
                    lualine_x = {
                        {
                            'diagnostics',
                            cond = hide
                        },
                        {
                            'lsp_status',
                            cond = hide
                        },
                        {
                            'filetype',
                            icon_only = true
                        },
                    },
                    lualine_y = {
                        'progress',
                    },
                    lualine_z = {
                        'location',
                    }
                }
            })
        end,
    },
}
