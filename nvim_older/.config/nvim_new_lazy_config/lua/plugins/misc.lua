return {
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "szw/vim-maximizer",
        keys = {
            { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize split" },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {
            indent = {
                char = "│",
            },
            scope = {
                enabled = false,
            },
        },
    },
    {
        "catgoose/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            user_default_options = {
                names = false,
                xterm = true,
                mode = "virtualtext",
                virtualtext = "󱓻 ",
                virtualtext_inline = true,
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        "windwp/nvim-ts-autotag",
        ft = { "html", "javascriptreact", "typescriptreact" },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    }
}
