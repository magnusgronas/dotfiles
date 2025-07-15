local M = {}

local get_theme_tb = require("base46").get_theme_tb
local colors = get_theme_tb("base_30")
local config = require("nvconfig")

local statusline_bg = config.base46.transparency and "NONE" or colors.statusline_bg
local text_fg = colors.grey

local hl = vim.api.nvim_set_hl
hl(0, "StatusLine", { bg = "none" })
-- FIX: For some reason this single line fixes all the diff icons being white
hl(0, "lualine_c_diff_added_insert", { fg = colors.green })

M.theme = {
    normal = {
        a = { fg = text_fg, bg = colors.nord_blue },
        b = { fg = colors.grey_fg2, bg = colors.lightbg },
        c = { fg = colors.grey_fg, bg = statusline_bg },
    },
    insert = {
        a = { fg = text_fg, bg = colors.green },
        b = { fg = colors.grey_fg2, bg = colors.lightbg },
        c = { fg = colors.grey_fg, bg = statusline_bg },
    },
    visual = {
        a = { fg = text_fg, bg = colors.purple },
        b = { fg = colors.grey_fg2, bg = colors.lightbg },
        c = { fg = colors.grey_fg, bg = statusline_bg },
    },
    replace = {
        a = { fg = text_fg, bg = colors.orange },
        b = { fg = colors.grey_fg2, bg = colors.lightbg },
        c = { fg = colors.grey_fg, bg = statusline_bg },
    },
    command = {
        a = { fg = text_fg, bg = colors.red },
        b = { fg = colors.grey_fg2, bg = colors.lightbg },
        c = { fg = colors.grey_fg, bg = statusline_bg },
    },
    inactive = {},
}

return M
