local custom_theme = require 'lualine.themes.yellowbeans-monochrome'

custom_theme.normal.a.bg = '#000000'
custom_theme.normal.b.bg = '#000000'
custom_theme.normal.c.bg = '#000000'

custom_theme.insert.a.bg = '#000000'
custom_theme.command.a.bg = '#000000'
custom_theme.replace.a.bg = '#000000'
custom_theme.visual.a.bg = '#000000'

custom_theme.inactive.a.bg = '#000000'
custom_theme.inactive.b.bg = '#000000'
custom_theme.inactive.c.bg = '#000000'

return {
  'nvim-lualine/lualine.nvim',
  event = 'BufEnter',
  opts = {
    options = {
      theme = custom_theme,
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      globalstatus = true,
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
    extensions = { 'quickfix', 'man', 'fugitive' },
  },
}
