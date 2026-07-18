return {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-mini/mini.icons" },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        win_options = {
            -- winbar = "%!v:lua.get_oil_winbar()"
        },
    },
    keys = {
        { "<leader>e", ":Oil --float --preview<CR>", desc = "Open Oil" },
    },
}
