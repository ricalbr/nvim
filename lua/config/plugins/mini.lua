return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = 'BufReadPre',
    config = function()
      require('mini.ai').setup()
      require('mini.bracketed').setup()
      require('mini.comment').setup()
      require('mini.jump').setup()
      require('mini.pairs').setup()
      require('mini.tabline').setup { show_icons = false }
      require('mini.surround').setup()
    end,
  },
}
