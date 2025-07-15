return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {},
  opts = {
    check_ts = true,
    ts_config = {
      lua = {"string"},
      javascript = {"template_string"},
      java = false,
    },
  },
}
