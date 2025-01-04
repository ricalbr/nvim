return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 500, -- delay between pressing a key and opening which-key (milliseconds)
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {},

      spec = { -- Document existing key chains
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
}
