local ok_tabline, tabline = pcall(require, "tabby.tabline")
if not ok_tabline then
    return
end

local ok_api, tab_api = pcall(require, "tabby.module.api")
if not ok_api then
    return
end

local function clean_tab_name(name)
    local cleaned = name:gsub("%[..%]", "")
    if cleaned == "" then
        return "[No Name]"
    end
    return cleaned
end

local function tab_modified(tabid)
    for _, win in ipairs(tab_api.get_tab_wins(tabid)) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].modified then
            return "●"
        end
    end

    return "○"
end

local theme = {
    fill = { bg = "#282c34" },
    head = { fg = "#1d1f24", bg = "#5da7e4" },
    current_tab = { fg = "#1d1f24", bg = "#5da7e4" },
    inactive_tab = { fg = "#a3aab8", bg = "#1d1f24" },
    tail = { fg = "#282c34", bg = "#61afef" },
}

tabline.set(function(line)
    return {
        {
            { "  ", hl = theme.head },
            line.sep("", theme.head, theme.fill),
        },

        line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.inactive_tab

            return {
                line.sep("", hl, theme.fill),
                tab.number(),
                "",
                clean_tab_name(tab.name()),
                "",
                tab_modified(tab.id),
                line.sep("", hl, theme.fill),
                hl = hl,
                margin = " ",
            }
        end),

        line.spacer(),

        {
            line.sep("", theme.tail, theme.fill),
            { "  ", hl = theme.tail },
        },

        hl = theme.fill,
    }
end)
