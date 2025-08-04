local get_theme_tb = require("base46").get_theme_tb
local colors = get_theme_tb("base_30")

local hl = vim.api.nvim_set_hl

-- Show available highlights with :lua Snacks.picker.highlights()

-- Matching block character () [] {}
hl(0, "MatchParen", { fg = colors.orange, bg = "none", bold = true })

-- Hover docs
hl(0, "", {})

-- Which-key
hl(0, "WhichKeyBorder", { fg = "none", bg = "none" })
hl(0, "WhichKeyTitle", { bg = "none" })
