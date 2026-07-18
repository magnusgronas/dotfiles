-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight text after yanking",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Restore cursor position in files
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.schedule(function()
                vim.cmd("normal! zz")
            end)
        end
    end,
})

-- Open help in v split
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    command = "wincmd L",
})

-- No auto comment on new line
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("no_auto_comment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Syntax highlighting for .env files
vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
    pattern = { ".env", ".env.*" },
    callback = function()
        vim.bo.filetype = "dosini"
    end,
})

-- Show cursorline only in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("cursorline_active", { clear = true }),
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = "cursorline_active",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

-- Lsp progress indicator
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(vim.lsp.status(), "info", {
            id = "lsp_progress",
            title = "LSP Progress",
            opts = function(notif)
                notif.icon = ev.data.params.value.kind == "end" and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

-- Restore cursor when exiting nvim
vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        os.execute("echo -ne \\\\033[5 q")
    end,
})

-- 2 space indentation for some filetypes
-- vim.api.nvim_create_autocmd("FileType", {
--     group = vim.api.nvim_create_augroup("indentation", { clear = true }),
--     pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "html", "css" },
--     callback = function()
--         vim.notify("Indentation width set to 2", "info", { title = "Indentation" })
--         vim.opt_local.shiftwidth = 2
--         vim.opt_local.tabstop = 2
--         vim.opt_local.softtabstop = 2
--     end,
-- })

local map = function(lhs, rhs, opts, mode)
    local options = { noremap = true, silent = true }
    mode = mode or "n"
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Lsp keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_keymap", { clear = true }),
    callback = function(args)
        local buf = args.buf
        map("gra", vim.lsp.buf.code_action, {desc = "Code Actions", buffer=buf})
        map("grn", vim.lsp.buf.rename, { desc = "Rename Symbol", buffer=buf})
        map("gd", function()
            Snacks.picker.lsp_definitions()
        end, { desc = "Goto Definition", buffer=buf })
        map("gD", function()
            Snacks.picker.lsp_declarations()
        end, { desc = "Goto Declaration (C/C++)", buffer=buf })
        map("grr", function()
            Snacks.picker.lsp_references()
        end, { desc = "References", buffer=buf})
        map("gri", function()
            Snacks.picker.lsp_implementations()
        end, { desc = "Goto Implementation", buffer=buf })
        map("grt", function()
            Snacks.picker.lsp_type_definitions()
        end, { desc = "Goto Type Definition", buffer=buf })
        map("gai", function()
            Snacks.picker.lsp_incoming_calls()
        end, { desc = "Calls Incoming", buffer=buf })
        map("gao", function()
            Snacks.picker.lsp_outgoing_calls()
        end, { desc = "Calls Outgoing", buffer=buf })
        map("<leader>ss", function()
            Snacks.picker.lsp_symbols()
        end, { desc = "Lsp Symbols" })
        map("<leader>sS", function()
            Snacks.picker.lsp_workspace_symbols()
        end, { desc = "Lsp Workspace Symbols" })
    end,
})
