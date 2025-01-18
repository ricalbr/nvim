return {
  {
    'neovim/nvim-lspconfig',
    -- event = 'VeryLazy',
    dependencies = {
      'folke/neodev.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'glepnir/lspsaga.nvim', event = 'LspAttach' },
      { 'j-hui/fidget.nvim', event = 'LspAttach', opts = {} },
      { 'stevearc/conform.nvim', event = 'LspAttach', branch = 'nvim-0.9' },
    },
    config = function()
      require('neodev').setup {}

      local capabilities = nil
      if pcall(require, 'cmp_nvim_lsp') then
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      end

      local lspconfig = require 'lspconfig'

      local servers = {
        bashls = true,
        -- NOTE: pyright might not attach to python files, the problem is due to node or nodesj
        -- run: curl -sL https://deb.nodesource.com/setup_20.x | sudo bash -  && sudo apt-get update && sudo apt-get install nodejs
        -- eventually update the nodejs version
        pyright = true,
        html = { filetypes = { 'html', 'twig', 'hbs' } },
        lua_ls = true,
        clangd = true,
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == 'table' then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require('mason').setup {
        ui = {
          border = 'rounded',
        },
      }
      require('mason-lspconfig').setup()
      local ensure_installed = {
        'stylua',
        'lua_ls',
        'clangd',
        'clang-format',
        'pyright',
      }

      vim.list_extend(ensure_installed, servers_to_install)
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend('force', {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      -- TODO: check highlighting vs tree-sitter
      local disable_semantic_tokens = {
        -- cpp = true,
        lua = true,
        -- python = true,
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), 'must have valid client')

          vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = 0 })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })

          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { buffer = 0 })

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })

      -- Autoformatting Setup
      require('conform').setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'isort', 'black' },
          cpp = { 'clang-format' },
        },
        formatters = {
          black = {
            prepend_args = { '--line-length', '120', '--fast', '--skip-string-normalization' },
          },
          prettier = {
            prepend_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
          },
        },
      }

      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function(args)
          require('conform').format {
            bufnr = args.buf,
            lsp_fallback = true,
            quiet = true,
          }
        end,
      })
    end,
  },
}
