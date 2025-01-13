return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = 'BufEnter',
    config = function()
      require('mini.ai').setup()
      require('mini.bracketed').setup()
      require('mini.comment').setup()
      require('mini.pairs').setup()
      require('mini.surround').setup()
    end,
  },
}
