return {
  {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.3', -- last version compatible with Nvim 0.9
    event = 'BufReadPre',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'BufReadPre' },
    },
    build = ':TSUpdate',
    branch = 'main',
    lazy = false,
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'cpp', 'latex', 'lua', 'markdown', 'markdown_inline', 'python', 'query', 'vim', 'vimdoc' },
        highlight = { enable = false },
      }
    end,
  },
}
