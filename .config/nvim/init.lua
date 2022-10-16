-- Activating plugins
require("plugins")
require("nvim-tree").setup()
require("neoscroll").setup()
require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }
}

-- Loading settings
require("settings")

-- Loading keybindings
require("keymaps")

-- Loading ui configs
require("ui.feline")
require("ui.tabby")

-- EXPAND TAB
vim.opt.expandtab = true
