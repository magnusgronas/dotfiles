local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("sh", {
	s("env", {
		t("#!/usr/bin/env bash"),
	}),
})


-- NOTE: Markdown

vim.keymap.set({ "i", "n", "s" }, "<A-b>", function()
	ls.snip_expand(s({ trig = "bold" }, {
		t("**"),
		i(1),
		t("** "),
	}))
end, { silent = true })

ls.add_snippets("markdown", {
	s("ch", {
		t("- [ ] "),
	}),
})
