return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      -- only load if `make` is available. make sure you have the system requirements installed.
      cond = function()
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
    require 'config.telescope'
  end,
}
