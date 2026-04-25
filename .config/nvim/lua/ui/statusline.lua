local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

local ok_catppuccin, catppuccin_lualine = pcall(require, "catppuccin.utils.lualine")
local theme = catppuccin_lualine("mocha")

lualine.setup({
    options = {
        theme = theme,
        globalstatus = true,
        disabled_filetypes = {
            statusline = {
                "NvimTree",
                "help",
                "qf",
            },
        },
        section_separators = {
            left = "",
            right = "",
        },
        component_separators = {
            left = "",
            right = "",
        },
    },

    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
            {
                "filename",
                path = 1,
                symbols = {
                    modified = " ●",
                    readonly = " ",
                    unnamed = "[No Name]",
                },
            },
        },
        lualine_x = {
            "diagnostics",
            "encoding",
            "fileformat",
            "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                "filename",
                path = 1,
            },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
})
