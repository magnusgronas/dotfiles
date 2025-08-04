return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below

        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = {
            enabled = true,
            replace_netrw = true,
            layout = {
                cycle = false,
            },
        },

        git = { enabled = true },
        gitbrowse = { enabled = false },
        indent = { enabled = false, },
        input = {
            enabled = true,
            icon_pos = "left",
            prompt_pos = "title",
            win = { style = "input" },
            expand = true,
        },
        lazygit = { enabled = true },
        notifier = { enabled = true },
        picker = {
            enabled = true,
            matchers = {
                frecency = true,
                cwd_bonus = true,
            },
            formatters = {
                file = {
                    filename_first = true,
                    filename_only = false,
                    icon_width = 2,
                },
            },
            layout = {
                cycle = false,
                -- preset = "telescope",
            },
            layouts = {},
        },
        quickfile = { enabled = true },
        rename = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = true },
        words = { enabled = false },
        image = { enabled = true },

        -- NOTE: Styling for the various modules
        styles = {
            input = {
                relative = "cursor",
                width = 40,
            },
        },
    },
    keys = {
        {
            "<leader>rN",
            function()
                Snacks.rename.rename_file()
            end,
            desc = "Rename current file",
        },

        -- Picker
        {
            "<leader>e",
            function()
                Snacks.explorer()
            end,
            desc = "Open file explorer",
        },
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fc",
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find config files",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.recent()
            end,
            desc = "Find recent files",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep search",
        },
        {
            "<leader>fwg",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Find visual selection or word",
            mode = { "n", "x" },
        },
        {
            "<leader>fk",
            function()
                Snacks.picker.keymaps({ layout = "ivy" })
            end,
            desc = "Find keymaps",
        },
        {
            "<leader>fh",
            function()
                Snacks.picker.help()
            end,
            desc = "Find help pages",
        },
        {
            "<leader>fH",
            function()
                Snacks.picker.highlights()
            end,
            desc = "Find highlights",
        },

        -- Git
        {
            "<leader>go",
            function()
                Snacks.lazygit.open()
            end,
            desc = "Open Lazy Git",
        },
        {
            "<leader>gbr",
            function()
                Snacks.picker.git_branches({ layout = "select" })
            end,
            desc = "Show git branches",
        },
    },
}
