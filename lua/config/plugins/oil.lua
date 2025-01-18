return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { "-", "<cmd>Oil <CR>", desc = "Open parent directory" },
    },
    config = function()
      require('oil').setup {
        columns = { 'icon' },
        keymaps = {
          ['<C-h>'] = false,
          ['<M-h>'] = 'actions.select_split',
          ['<M-v>'] = 'actions.select_vsplit',
        },
        view_options = {
          show_hidden = true,
        },
      }
    end,
  },
}
