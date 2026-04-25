local install_dir = vim.fn.stdpath("data") .. "/site"
local pan_root = "/home/ashooww/Projects/tree-sitter-pansexual"

local parser_filetypes = {
    "c",
    "cpp",
    "css",
    "html",
    "lua",
    "markdown",
    "python",
    "rust",
    "scss",
    "typescript",
    "pan",
}

local parsers_to_install = {
    "c",
    "cpp",
    "css",
    "html",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "scss",
    "typescript",
    "pan",
}

require("nvim-treesitter").setup({
    install_dir = install_dir,

    local_parsers = {
        pan = {
            source = {
                type = "local",
                path = pan_root,
                queries_path = "queries/pan",
            },
            filetypes = { "pan" },
        },
    },
})

-- No-op for parsers that are already installed.
require("nvim-treesitter").install(parsers_to_install)

vim.api.nvim_create_augroup("UserTreesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = "UserTreesitter",
    pattern = parser_filetypes,
    callback = function()
        local ok = pcall(vim.treesitter.start)

        if ok then
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
    end,
})

vim.o.foldlevelstart = 99
