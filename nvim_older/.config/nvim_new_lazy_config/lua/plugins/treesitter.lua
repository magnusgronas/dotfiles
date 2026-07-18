return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
        local treesitter = require("nvim-treesitter")

        local ensure_installed = {
            "json", "javascript", "typescript", "tsx", "go", "yaml", "html", "css", "python", "http",
            "markdown", "markdown_inline", "bash", "lua", "vim",
            "gitignore", "vimdoc", "c", "java", "rust",
        }

        treesitter.install(ensure_installed)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function(args)
                local buf = args.buf
                local ft = vim.bo[buf].filetype
                local lang = vim.treesitter.language.get_lang(ft)

                if not lang then
                    return
                end

                local ok_add = pcall(vim.treesitter.language.add, lang)
                if not ok_add then
                    return
                end

                pcall(vim.treesitter.start, buf, lang)

                if ft ~= "yaml" and ft ~= "markdown" then
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    vim.bo[buf].smartindent = false
                    vim.bo[buf].cindent = false
                end
            end,
        })
    end
}
