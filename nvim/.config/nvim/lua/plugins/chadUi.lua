return {
    "nvim-lua/plenary.nvim",

    { "nvim-tree/nvim-web-devicons", lazy = true },

    {
        "nvchad/ui",
        lazy = true,
        config = function()
            require("nvchad")
        end,
    },

    {
        "nvchad/base46",
        lazy = true,
        build = function()
            require("base46").load_all_highlights()
        end,
    },
}
