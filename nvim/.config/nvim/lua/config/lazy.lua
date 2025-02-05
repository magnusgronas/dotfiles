-- base46
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	change_detection = {
		notify = false,
	},
	-- automatically check for plugin updates
	checker = {
		enabled = true,
		notify = false,
	},
})

-- base46
-- dofile(vim.g.base46_cache .. "defaults")
-- dofile(vim.g.base46_cache .. "statusline")
-- dofile(vim.g.base46_cache .. "treesitter")
-- dofile(vim.g.base46_cache .. "syntax")
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end
