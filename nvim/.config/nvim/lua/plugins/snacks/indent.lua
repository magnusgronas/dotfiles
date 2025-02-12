return {
	priority = 1,
	enabled = true, -- enable indent guides
	char = "▎",
	only_scope = false, -- only show indent guides of the scope
	only_current = false, -- only show indent guides in the current window
	hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
	-- hl = {
	--     "SnacksIndent1",
	--     "SnacksIndent2",
	--     "SnacksIndent3",
	--     "SnacksIndent4",
	--     "SnacksIndent5",
	--     "SnacksIndent6",
	--     "SnacksIndent7",
	--     "SnacksIndent8",
	-- },
	animate = {
		enabled = false,
	},
	scope = {
		enabled = false,
	},
}
