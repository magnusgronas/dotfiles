local M = {}

M.hide = function()
	return vim.fn.winwidth(0) > 65
end

M.lsp = function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end

	local client_names = {}
	for _, client in ipairs(clients) do
		table.insert(client_names, client.name)
	end

	if client_names[1] == "null-ls" then
		return client_names[2]
	end

	return client_names[1]
end

M.space = function()
	return " "
end

M.close = function()
	return "x"
end

return M
