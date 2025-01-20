return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = 'BufReadPre',
    config = function()
      require('mini.bracketed').setup()
      require('mini.comment').setup()
      require('mini.jump').setup()
      -- require('mini.pairs').setup()
      require('mini.tabline').setup { show_icons = false }
      -- require('mini.surround').setup()
    end,
  },

  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'BufReadPre',
    opts = {},
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
}
