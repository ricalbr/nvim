return {
  {
    'hrsh7th/nvim-cmp', -- autocompletion
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp', event = 'InsertEnter' },
      { 'hrsh7th/cmp-path', event = 'InsertEnter' },
      { 'hrsh7th/cmp-emoji', event = 'InsertEnter' },
      { 'onsails/lspkind.nvim', event = 'BufEnter' },
      { 'roobert/tailwindcss-colorizer-cmp.nvim', event = 'BufEnter' },
      { 'hrsh7th/cmp-buffer', event = 'InsertEnter' },
      { 'saadparwaiz1/cmp_luasnip', event = 'InsertEnter' },
      {
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
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
      -- { 'hrsh7th/cmp-cmdline', event = 'InsertEnter' },
      -- { 'hrsh7th/cmp-nvim-lua' },
    },
    config = function()
      require 'config.completion'
    end,
  },
}
