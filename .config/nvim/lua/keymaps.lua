local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}
local expr_opts = {noremap = true, silent = true, expr = true}
local map_opts = {silent = true}

vim.cmd[[
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12> m`:TrimSpaces<CR>``
]]

map("n", "gd", "<Plug>(coc-definition)", map_opts)
map("n", "gy", "<Plug>(coc-type-definition)", map_opts)
map("n", "gi", "<Plug>(coc-implementation)", map_opts)
map("n", "gr", "<Plug>(coc-references)", map_opts)
map("n", "K", ":call ShowDocumentation()<CR>", map_opts)
map("n", "<leader>rn", "<Plug>(coc-rename)", {})
map("i", "<C-Space>", "coc#refresh()", expr_opts)
map("i", "<Tab>", 'coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\\<Tab>" : coc#refresh()', expr_opts)
map("i", "<S-Tab>", 'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-h>"', expr_opts)
map("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<C-g>u<CR><c-r>=coc#on_enter()<CR>'", expr_opts)
map("n", "<F4>", ":bd<CR>", default_opts)
map("n", "<C-n>", ":NvimTreeToggle<CR>", default_opts)
map("n", "<F5>", ":NvimTreeFocus<CR>", default_opts)
map("n", "<F6>", ":sp<CR>:terminal<CR>", default_opts)
map("n", "<F7>", ":tabnew<CR>:terminal<CR>", default_opts)
map("n", "<C-Down>", ":hide<CR>", default_opts)
map("n", "<Tab>", "gt", default_opts)
map("n", "<S-Tab>", "gT", default_opts)
map("n", "<C-w>", ":tabclose<CR>", default_opts)
map("t", "<Esc>", "<C-\\><C-n>", default_opts)

if vim.fn.has("nvim-0.4.0") or vim.fn.has("patch-8.2.0750") then
  map("i", "<C-J>", "coc#float#scroll(1)", expr_opts);
  map("i", "<C-K>", "coc#float#scroll(0)", expr_opts);
end

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
