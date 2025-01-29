return {
  {
    'hrsh7th/nvim-cmp', -- autocompletion
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'onsails/lspkind.nvim',
      'roobert/tailwindcss-colorizer-cmp.nvim',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        config = function()
          require('luasnip.loaders.from_lua').lazy_load { paths = { '~/.config/nvim/lua/snippets/' } }
        end,
      },
    },
    config = function()
      require 'plugins.config.completion'
    end,
  },
}
