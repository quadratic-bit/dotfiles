local opt = vim.opt
local g = vim.g

g.mkdp_highlight_css = "/home/ashooww/.config/highlightjs/a11y.css"
g.vimtex_view_method = "zathura"
g.matchup_override_vimtex = 1
g.matchup_matchparen_deferred = 1

opt.showmode = false
opt.backup = false
opt.writebackup = false
opt.updatetime = 300
opt.foldenable = false
opt.scrolloff = 10
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.splitright = true
opt.splitbelow = true
opt.completeopt = { "noinsert", "menuone", "noselect" }
opt.signcolumn = "number"
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.mouse = "a"
opt.colorcolumn = "80"

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

require("catppuccin").setup({
    highlight_overrides = {
        mocha = function(mocha)
            return {
                Comment = { fg = mocha.subtext0 },
            }
        end,
    },
})

vim.cmd.colorscheme("catppuccin-mocha")
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
