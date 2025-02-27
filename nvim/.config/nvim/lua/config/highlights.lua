---------------------------------
-- hl group overrides

-- Some overrides are located in
-- plugins/chadrc.lua
---------------------------------
local hl = vim.api.nvim_set_hl
-- vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#b4befe" })
-- vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#b4befe" })
-- vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#45475a" })
-- vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", { fg = "#f2cdcd" })

-- Snacks Picker
hl(0, "SnacksPickerBorder", { fg = "#181825", bg = "#181825" })
hl(0, "SnacksPickerInputTitle", { fg = "#4c4f69", bg = "#cba6f7" })
hl(0, "SnacksPickerInputBorder", { bg = "#11111b", fg = "#11111b" })
hl(0, "SnacksPickerInput", { bg = "#11111b", fg = "#cdd6f4" })
hl(0, "SnacksPickerListTitle", { bg = "#f2cdcd", fg = "#4c4f69" })
hl(0, "SnacksPickerPreviewTitle", { bg = "#a6e3a1", fg = "#4c4f69" })

-- Lualine
hl(0, "LualineDiff", { fg = "#6c7086" })

-- Blink-cmp
hl(0, "BlinkCmpGhostText", { fg = "#6c7086" })
hl(0, "BlinkCmpMenu", { bg = "#1e1e2e" })
hl(0, "BlinkCmpMenuBorder", { bg = "#1e1e2e", fg = "#313244" })
