local M = {}

M.base46 = {
    -- theme = "tokyonight",
    -- theme = "onedark",
    theme = "catppuccin",
    transparency = true,
    hl_override = {
        -- ["@property"] = { fg = "red" },
    },
}

M.nvdash = {
    enabled = false,
}

M.ui = {
    statusline = {
        enabled = false,
    },
}

M.lsp = {
    signature = false,
}

return M
