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
    ensure_installed = { "typescript", "lua", "python", "rust", "html", "markdown", "css", "scss" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    }
}

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

-- Loading settings
require"settings"

-- Loading keybindings
require"keymaps"

-- Loading ui configs
require"ui.statusline"
require"ui.tabby"

-- EXPAND TAB
vim.opt.expandtab = true
