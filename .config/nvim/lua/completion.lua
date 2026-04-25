local ok_cmp, cmp = pcall(require, "cmp")
if not ok_cmp then
    return
end

local ok_luasnip, luasnip = pcall(require, "luasnip")
if not ok_luasnip then
    return
end

local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))

    if col == 0 then
        return false
    end

    local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    return current_line:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    mapping = {
        ["<C-b>"] = cmp.mapping(function()
            cmp.scroll_docs(-4)
        end, { "i", "s" }),

        ["<C-f>"] = cmp.mapping(function()
            cmp.scroll_docs(4)
        end, { "i", "s" }),

        ["<C-Space>"] = cmp.mapping(function()
            cmp.complete()
        end, { "i", "s" }),

        ["<C-e>"] = cmp.mapping(function()
            cmp.abort()
        end, { "i", "s" }),

        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true })
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
    }, {
        { name = "buffer" },
    }),
})

cmp.setup.filetype("lua", {
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
    }, {
        { name = "buffer" },
    }),
})
