Snacks.notifier.notify("JavaScript ftplugin loaded", "info", { title = "JavaScript" })

local hl = vim.api.nvim_set_hl
local colors = require("tokyonight.colors").setup()

hl(0, "@variable.member.javascript", { fg = colors.blue })
