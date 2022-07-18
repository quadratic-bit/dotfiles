local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}
local expr_opts = {noremap = true, silent = true, expr = true}
local map_opts = {silent = true}

vim.cmd[[
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]]

map("n", "gd", "<Plug>(coc-definition)", map_opts)
map("n", "gy", "<Plug>(coc-type-definition)", map_opts)
map("n", "gi", "<Plug>(coc-implementation)", map_opts)
map("n", "gr", "<Plug>(coc-references)", map_opts)
map("i", "<C-Space>", "coc#refresh()", expr_opts)
map("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : CheckBackspace() ? "\\<TAB>" : coc#refresh()', expr_opts)
map("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-g>u<CR><c-r>=coc#on_enter()<CR>'", expr_opts)
map("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<C-h>"', expr_opts)
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

