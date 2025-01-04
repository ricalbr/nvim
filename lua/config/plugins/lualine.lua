return {
  'nvim-lualine/lualine.nvim',
  event = 'BufRead',
  opts = {

    options = {
      theme = 'iceberg_dark',
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
