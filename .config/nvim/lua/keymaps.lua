local map = vim.keymap.set

local function show_spaces(force)
    vim.fn.setreg("/", [[\v(\s+$)|( +\ze\t)]])

    if force == nil then
        vim.o.hlsearch = not vim.o.hlsearch
    else
        vim.o.hlsearch = force
    end

    return vim.o.hlsearch
end

vim.api.nvim_create_user_command("ShowSpaces", function(opts)
    if opts.args == "" then
        show_spaces(nil)
    else
        show_spaces(opts.args ~= "0")
    end
end, {
    nargs = "?",
    desc = "Toggle or set whitespace search highlighting",
})

vim.api.nvim_create_user_command("TrimSpaces", function(opts)
    local old_hlsearch = vim.o.hlsearch
    show_spaces(true)
    vim.cmd(("%d,%ds///gec"):format(opts.line1, opts.line2))
    vim.o.hlsearch = old_hlsearch
end, {
    range = "%",
    desc = "Interactively trim trailing spaces",
})

map("n", "<F12>", function()
    vim.cmd("normal! m`")
    vim.cmd("TrimSpaces")
    vim.cmd("normal! ``")
end, {
    desc = "Trim trailing spaces",
})

map("n", "<F4>", "<cmd>bd<CR>", { silent = true, desc = "Delete buffer" })
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { silent = true, desc = "Toggle file tree" })
map("n", "<F5>", "<cmd>NvimTreeFocus<CR>", { silent = true, desc = "Focus file tree" })
map("n", "<F6>", "<cmd>split | terminal<CR>", { silent = true, desc = "Horizontal terminal" })
map("n", "<F7>", "<cmd>tabnew | terminal<CR>", { silent = true, desc = "Terminal tab" })
map("n", "<C-Down>", "<cmd>hide<CR>", { silent = true, desc = "Hide window" })
map("n", "<Tab>", "gt", { silent = true, desc = "Next tab" })
map("n", "<S-Tab>", "gT", { silent = true, desc = "Previous tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { silent = true, desc = "Close tab" })
map("t", "<Esc>", "<C-\\><C-n>", { silent = true, desc = "Terminal normal mode" })

local builtin = require("telescope.builtin")
map("n", "ff", builtin.find_files, { desc = "Find files" })
map("n", "fg", builtin.live_grep, { desc = "Live grep" })
map("n", "fb", builtin.buffers, { desc = "Buffers" })
map("n", "fh", builtin.help_tags, { desc = "Help tags" })

map("n", "<space>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
map("n", "<space>q", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = function(desc)
            return {
                buffer = ev.buf,
                silent = true,
                desc = desc,
            }
        end

        map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
        map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
        map("n", "K", vim.lsp.buf.hover, opts("Hover"))
        map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
        map("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature help"))
        map("n", "<space>D", vim.lsp.buf.type_definition, opts("Type definition"))
        map("n", "<space>rn", vim.lsp.buf.rename, opts("Rename"))
        map({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts("Code action"))
        map("n", "gr", vim.lsp.buf.references, opts("References"))
        map("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts("Format buffer"))
    end,
})
