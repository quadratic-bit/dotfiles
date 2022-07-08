local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

map("n", "<F4>", ":bd<CR>", default_opts)
map("n", "<C-n>", ":NvimTreeToggle<CR>", default_opts)
map("n", "<F5>", ":NvimTreeFocus<CR>", default_opts)
map("n", "<F6>", ":sp<CR>:terminal<CR>", default_opts)
map("n", "<F7>", ":tabnew<CR>:terminal<CR>", default_opts)
map("t", "<Esc>", "<C-\\><C-n>", default_opts)
map("n", "<C-Down>", ":hide<CR>", default_opts)
map("n", "<Tab>", "gt", default_opts)
map("n", "<S-Tab>", "gT", default_opts)
map("n", "<C-w>", ":tabclose<CR>", default_opts)

