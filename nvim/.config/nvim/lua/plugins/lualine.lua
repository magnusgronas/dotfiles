return {
  {
    "nvim-lualine/lualine.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      local custom_theme = require("plugins.lualine.base46-theme").theme

      local hide = function()
        return vim.fn.winwidth(0) > 65
      end

      require("lualine").setup({
        options = {
          theme = custom_theme,
          disabled_filetypes = { statusline = { "snacks_dashoard" } },
          section_separators = {
            left = "",
            right = "",
          },
          component_separators = {
            left = "",
            right = "",
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            {
              "filename",
              path = 4,
              symbols = { modified = "", readonly = "", unnamed = "[No Name]", newfile = "󰝒", },
            }
          },
          lualine_c = {
            {
              "branch",
              icon = "󰘬",
              color = { fg = "#6e738d" },
              cond = hide,
            },
            {
              'diff',
              cond = hide
            }
          },
          lualine_x = {
            {
              'diagnostics',
              cond = hide
            },
            'lsp_status',
            {
              'filetype',
              icon_only = true
            },
          },
          lualine_y = {
            'progress',
          },
          lualine_z = {
            'location',
          }
        }
      })
    end,
  },
}
