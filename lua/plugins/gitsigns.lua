local icons = require 'plugins.config.icons'
local signs = {
  add = { text = icons.ui.BoldLineMiddle },
  change = { text = icons.ui.BoldLineMiddle },
  delete = { text = icons.ui.TriangleShortArrowRight },
  topdelete = { text = icons.ui.TriangleShortArrowRight },
  changedelete = { text = icons.ui.TriangleShortArrowRight },
  untracked = { text = '┆' },
}

return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPre',
  cmd = 'Gitsigns',
  opts = {
    signs = signs,
    signs_staged = signs,
    preview_config = {
      border = 'rounded',
    },
  },
}
