local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

g.mapleader = " "

g.vim_svelte_plugin_use_typescript = 1
g.vim_svelte_plugin_use_sass = 1
g.rustfmt_command = "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rustfmt"
g.rustfmt_autosave = 1

cmd"set noshowmode"
cmd"set nobackup"
cmd"set nowritebackup"
cmd"set updatetime=300"
opt.hidden = true
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.splitright = true
opt.splitbelow = true
opt.completeopt = "noinsert,menuone,noselect"
opt.signcolumn = "number"
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.lazyredraw = true
opt.mouse = "a"
opt.list = true
opt.colorcolumn = "100"

opt.termguicolors = true

cmd"colorscheme catppuccin-macchiato"
cmd[[
  filetype plugin indent on
  syntax on
]]
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
cmd"autocmd FileType htmldjango setlocal shiftwidth=2 softtabstop=2 expandtab"

-- No autocomment
cmd"au BufEnter * set fo-=c fo-=r fo-=o"

-- Better html template format
cmd"autocmd BufNewFile,BufRead *.html set filetype=htmldjango"

-- Sass stuff
cmd"autocmd FileType scss setl iskeyword+=@-@"

-- Remember last line
cmd[[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

-- Highlight copied text
cmd([[
  augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-- Something to deal with colours
cmd[[
  set t_Co=256
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
]]

