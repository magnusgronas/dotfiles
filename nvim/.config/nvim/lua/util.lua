local M = {}
-- Mapping function
M.map = function(lhs, rhs, opts, mode)
    local options = { noremap = true, silent = true }
    mode = mode or "n"
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

M.icons = {
    error = "",
    hint = "",
    info = "",
    warn = "",
    debug = "",
}

return M
