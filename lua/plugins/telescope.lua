return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() -- only load if `make` is available. make sure you have the system requirements installed.
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-smart-history.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'debugloop/telescope-undo.nvim',
  },
  opts = function()
    require('plenary.filetype').add_table {
      extension = {
        ['pgm'] = 'gcode',
        ['gcode'] = 'gcode',
        ['g'] = 'gcode',
        ['ngc'] = 'gcode',
      },
    }
  end,
  config = function()
    require 'plugins.config.telescope'
  end,
}
