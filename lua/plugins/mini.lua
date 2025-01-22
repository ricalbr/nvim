return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    event = 'BufReadPre',
    config = function()
      require('mini.ai').setup()
      require('mini.bracketed').setup()
      require('mini.comment').setup()
      require('mini.icons').setup()
      require('mini.jump').setup()
      -- require('mini.pairs').setup()
      require('mini.tabline').setup { show_icons = false }
      require('mini.surround').setup {
        mappings = {
          add = 'ys', --  defult  'sa'
          delete = 'ds', --  defult  'sd'
          find = '', --  defult  'sf'
          find_left = '', --  defult  'sF'
          highlight = '', --  defult  'sh'
          replace = 'cs', --  defult  'sr'
          update_n_lines = '', --  defult  'sn'

          suffix_last = '',
          suffix_next = '',
        },
        search_method = 'cover_or_next',
      }

      -- Remap adding surrounding to Visual mode selection
      vim.keymap.del('x', 'ys')
      vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

      -- Make special mapping for "add surrounding for line"
      vim.keymap.set('n', 'yss', 'ys_', { remap = true })
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },

  {
    'takac/vim-hardtime',
    cmd = 'HardTimeOn',
  },
}
