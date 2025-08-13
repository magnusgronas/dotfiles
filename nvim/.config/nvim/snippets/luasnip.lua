local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("sh", {
    s("env", {
        t("#!/usr/bin/env bash")
    })
})
