-- custom colorscheme
-- stylua: ignore start
local colors = {
  bg        =  '#000000',
  fg        =  '#E0E0E0',
  yellow    =  '#D79921',
  darkblue  =  '#458588',
  green     =  '#98971A',
  violet    =  '#B16286',
  blue      =  '#83A598',
}
-- stylua: ignore end

local custom_theme = {
    normal = {
        a = { fg = colors.blue, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
    },
    insert = {
        a = { fg = colors.green, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
    },
    visual = {
        a = { fg = colors.darkblue, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
    },
    replace = {
        a = { fg = colors.violet, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
    },
    command = {
        a = { fg = colors.yellow, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
    },
    inactive = {
        a = { fg = colors.bg, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
    },
}

return {
    {
        'nvim-lualine/lualine.nvim',
        event = 'BufReadPre',
        opts = {
            options = {
                theme = custom_theme,
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
            },
            sections = {
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'filetype' },
                lualine_y = { 'branch', 'diagnostics' },
            },
            inactive_sections = {
                lualine_b = { 'filename' },
                lualine_c = { '' },
            },
            extensions = { 'quickfix', 'man' },
        },
    },
}
