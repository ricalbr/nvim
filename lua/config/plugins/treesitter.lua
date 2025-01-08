return {
  {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.3', -- last version compatible with Nvim 0.9
    event = 'BufRead',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'VeryLazy' },
    },
    build = ':TSUpdate',
    branch = 'main',
    lazy = false,
    config = function()
      require 'config.treesitter'
    end,
  },
}
