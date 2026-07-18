require("colorful-menu").setup()
local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({

    keymap = {
        preset = "default",
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-c>"] = { "cancel", "fallback" },
        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
    },

    completion = {
        documentation = {
            auto_show = true,
        },

        ghost_text = {
            enabled = true,
        },
        menu = {
            draw = {
                columns = { { "kind_icon" }, { "label", gap = 1 } },
                components = {
                    label = {
                        text = function(ctx)
                            return require("colorful-menu").blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return require("colorful-menu").blink_components_highlight(ctx)
                        end
                    }
                }
            }
        }
    },
    cmdline = {
        enabled = true,
        keymap = { preset = "inherit" },
        completion = {
            ghost_text = { enabled = true },
            menu = {
                auto_show = true,
                draw = {
                    columns = {
                        { "kind_icon", "label", gap = 1 },
                    },
                },
            },
        },
    },
})
