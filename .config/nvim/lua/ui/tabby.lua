function tab_name(tab) 
   return string.gsub(tab,"%[..%]","") 
end

function tab_modified(tab)
    wins = require("tabby.module.api").get_tab_wins(tab)
    for i, x in pairs(wins) do
        if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
            return ""
        end
    end
    return ""
end

function GetFileExtension(url)
  return url:match("^.+(%..+)$"):sub(2)
end

local function get_modified(buf)
    if vim.bo[buf].modified then
        return ''
    else
        return ''
    end
end

local function get_devicon(filename)
    if string.find(filename,"NvimTree") then
        return "פּ"
    elseif string.find(filename,"SidebarNvim") then
        return "פּ"
    end
    if string.find(filename,"%.") and not string.sub(filename, 1, 1) == "." then
        ext = GetFileExtension(filename)
    else
        ext =''
    end
        return require'nvim-web-devicons'.get_icon(filename, ext, { default = true })
end

local function buffer_name(buf)
  if string.find(buf,"NvimTree") then 
        return "Filetree"
  elseif string.find(buf,"SidebarNvim") then 
        return "Sidebar"
    end
    return buf
end
local theme = {
  fill = {bg = "#282c34"},
  head = {fg = '#1d1f24', bg = '#5da7e4'},
  current_tab = {fg = '#1d1f24', bg = '#5da7e4'},
  inactive_tab = {bg ='#1d1f24', fg = '#a3aab8'},
  tab = {fg = '#abb2bf', bg = '#282c34'},
  win = {fg = '#282c34', bg = '#61afef'},
  tail = {fg = '#282c34', bg = '#61afef'},
}
require('tabby.tabline').set(function(line)
  return {
    {
      { '  ', hl = theme.head },
      line.sep('', theme.head, theme.fill),
    },
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.inactive_tab
      return {
        line.sep('', hl, theme.fill),
        tab.number(),
        "",
        tab_name(tab.name()),
        "",
        tab_modified(tab.id),
        line.sep('', hl, theme.fill),
        hl = hl,
        margin = ' ',
      }
    end),
    line.spacer(),
    {
      line.sep('', theme.tail, theme.fill),
      { '  ', hl = theme.tail },
    },
    hl = theme.fill,
  }
end)
