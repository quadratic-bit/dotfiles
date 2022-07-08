local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

g.vim_svelte_plugin_use_typescript = 1
g.vim_svelte_plugin_use_sass = 1

opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.splitright = true
opt.splitbelow = true
opt.completeopt = "noinsert,menuone,noselect"

opt.termguicolors = true
cmd"colorscheme nordfox"

cmd([[
  filetype plugin indent on
  syntax on
]])
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- No autocomment
cmd"au BufEnter * set fo-=c fo-=r fo-=o"

-- Better html template format
cmd"autocmd BufNewFile,BufRead *.html set filetype=htmldjango"

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
