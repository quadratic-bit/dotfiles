require("startup")

require("plugins")

require("filetypes")

require("nvim-tree").setup {
    git = {
        enable = true,
        ignore = false
    }
}

require("treesitter")

require("ibl").setup()
require("todo-comments").setup()

require("settings")
require("languages")
require("autocmds")

require("completion")
require("keymaps")

require("lsp")

require("ui.statusline")
require("ui.tabby")
