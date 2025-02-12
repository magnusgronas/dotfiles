return {
	-- {
	-- 	"<leader>fb",
	-- 	function()
	-- 		Snacks.picker.buffers()
	-- 	end,
	-- 	desc = "Buffers",
	-- },
	-- {
	-- 	"<leader>fc",
	-- 	function()
	-- 		Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
	-- 	end,
	-- 	desc = "Find Config File",
	-- },
	{
		"<leader>ff",
		function()
			Snacks.picker.files()
		end,
		desc = "Find Files",
	},
	-- {
	-- 	"<leader>fg",
	-- 	function()
	-- 		Snacks.picker.git_files()
	-- 	end,
	-- 	desc = "Find Git Files",
	-- },
	-- {
	-- 	"<leader>fp",
	-- 	function()
	-- 		Snacks.picker.projects()
	-- 	end,
	-- 	desc = "Projects",
	-- },
	-- {
	-- 	"<leader>fr",
	-- 	function()
	-- 		Snacks.picker.recent()
	-- 	end,
	-- 	desc = "Recent",
	-- },
	{
		"<leader>z",
		function()
			Snacks.zen()
		end,
		desc = "Enable Zen Mode",
	},
	{
		"<leader>Z",
		function()
			Snacks.zen.zoom()
		end,
		desc = "Enable Zen Mode",
	},
}
