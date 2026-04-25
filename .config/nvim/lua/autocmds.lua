local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    group = augroup("UserYankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 700,
        })
    end,
    desc = "Highlight yanked text",
})

autocmd("BufReadPost", {
    group = augroup("UserRestoreCursor", { clear = true }),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line = mark[1]
        local last_line = vim.api.nvim_buf_line_count(0)

        if line > 1 and line <= last_line then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
    desc = "Restore last cursor position",
})

autocmd("BufEnter", {
    group = augroup("UserNoAutoComment", { clear = true }),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
    desc = "Do not continue comments automatically",
})
