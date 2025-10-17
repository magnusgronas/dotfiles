local colors = require("tokyonight.colors").setup()
local hl = vim.api.nvim_set_hl

-- Show available highlights with :lua Snacks.picker.highlights() (mapped to "<leader>fH")

-- BlinkCmp
hl(0, "BlinkCmpMenu", {bg = colors.bg_popup})

-- Split separator
hl(0, "WinSeparator", { fg = colors.blue5 })

-- Matching block character () [] {}
hl(0, "MatchParen", { fg = colors.orange, bg = "none", bold = true })

-- Hover docs
hl(0, "", {})

-- Which-key
hl(0, "WhichKeyBorder", { fg = "none", bg = "none" })
hl(0, "WhichKeyTitle", { bg = "none" })

-- Bufferline
hl(0, "BufferLineFill", { fg = "none", bg = "none" })

