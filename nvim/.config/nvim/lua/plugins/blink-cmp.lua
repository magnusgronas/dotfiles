return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    event = "InsertEnter",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            config = function() -- Add a config function for LuaSnip itself
                -- Load friendly-snippets (VS Code format)
                require("luasnip.loaders.from_vscode").lazy_load()

                -- Load your custom snippets from nvim/snippets/luasnip.lua
                -- Make sure this path is correct relative to your Neovim config root
                dofile(vim.fn.stdpath("config") .. "/snippets/luasnip.lua")
            end,
            dependencies = {
                "rafamadriz/friendly-snippets", -- friendly-snippets does not need a config function here anymore
            },
        },
        "xzbdmw/colorful-menu.nvim",
    },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
            preset = "default",
            ["<Tab>"] = { "select_and_accept", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-c>"] = { "cancel", "fallback" },
            ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
            ["<C-l>"] = { "snippet_forward", "fallback" },
            ["<C-h>"] = { "snippet_backward", "fallback" },
            ["<C-space>"] = { "show", "fallback" },
        },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        signature = {
            enabled = false,
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
            menu = {
                max_height = 20,
                min_width = 20,
                scrollbar = true,
                border = "none",
                draw = {
                    padding = 2,
                    columns = {
                        { "kind_icon" },
                        { "label",    gap = 2, "kind" },
                    },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
                cmdline_position = function()
                    local row, col
                    if vim.g.ui_cmdline_pos ~= nil then
                        local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                        row = pos[1] - 1
                        col = pos[2]
                    else
                        local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                        row = vim.o.lines - height
                        col = 0
                    end
                    return { row + 1, col }
                end,
            },
            documentation = {
                auto_show = true,
                window = {
                    border = "rounded",
                },
            },
            ghost_text = {
                enabled = true,
                show_without_selection = false,
            },
        },

        cmdline = {
            enabled = true,
            keymap = { preset = "inherit" },
            completion = {
                menu = {
                    auto_show = true,
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "label" },
                        },
                    },
                },
            },
        },
        snippets = { preset = "luasnip" },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {},
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "rust" },
    },
    opts_extend = { "sources.default" },
}
