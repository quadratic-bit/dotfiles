local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local language_group = augroup("UserLanguagePolicy", { clear = true })

local function set_local(opts)
    for key, value in pairs(opts) do
        vim.opt_local[key] = value
    end
end

autocmd("FileType", {
    group = language_group,
    pattern = "htmldjango",
    callback = function()
        set_local({
            shiftwidth = 2,
            softtabstop = 2,
            expandtab = true,
        })
    end,
})

autocmd("FileType", {
    group = language_group,
    pattern = "nasm",
    callback = function()
        set_local({
            shiftwidth = 8,
            softtabstop = 8,
            expandtab = true,
        })
    end,
})

autocmd("FileType", {
    group = language_group,
    pattern = { "c", "cpp" },
    callback = function()
        set_local({
            autoindent = true,
            expandtab = false,
            shiftwidth = 8,
            tabstop = 8,
        })
    end,
})

autocmd("FileType", {
    group = language_group,
    pattern = { "tex", "markdown" },
    callback = function()
        set_local({
            spell = true,
            spelllang = { "en_us", "ru_yo" },
        })
    end,
})

autocmd("FileType", {
    group = language_group,
    pattern = "scss",
    callback = function()
        vim.opt_local.iskeyword:append("@-@")
    end,
})

autocmd({ "BufRead", "BufNewFile" }, {
    group = language_group,
    pattern = {
        "/home/ashooww/Projects/toys/optick/*",
        "/home/ashooww/Projects/toys/swuix/*",
        "/home/ashooww/Projects/mipt-ded-zemax/*",
    },
    callback = function()
        if vim.bo.filetype == "cpp" then
            set_local({
                expandtab = true,
                shiftwidth = 4,
                tabstop = 4,
            })
        end
    end,
})
