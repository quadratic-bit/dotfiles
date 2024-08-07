-- Activating plugins
require"plugins"
require"nvim-tree".setup {
    git = {
        enable = true,
        ignore = false
    }
}
require"leap".add_default_mappings()
require"nvim-treesitter.configs".setup {
    ensure_installed = { "typescript", "lua", "python", "rust", "html", "markdown", "css", "scss", "cpp" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    }
}

vim.filetype.add({extension = {mql = "cpp"}})
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.mql = {
    install_info = {
        url = "/home/ashooww/.local/src/tree-sitter-mql5",
        files = {"src/parser.c"}
    },
}

require("ibl").setup()

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 99

-- LSP
local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)
lsp.ensure_installed({
    "tsserver",
    "rust_analyzer",
    "pyright",
    "html",
    "marksman",
    "cssls"
})
lsp.setup()

local lspconfig = require("lspconfig")
lspconfig.html.setup {
    filetypes = { "html", "htmldjango" }
}

lspconfig.cssls.setup {
    filetypes = { "css", "scss" }
}
lspconfig.rust_analyzer.setup {
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                allTargets = false
            }
        },
    }
}

-- Loading settings
require"settings"

-- Loading keybindings
require"keymaps"

-- Loading ui configs
require"ui.statusline"
require"ui.tabby"

-- EXPAND TAB
vim.opt.expandtab = true
