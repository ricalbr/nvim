---@diagnostic disable-next-line: missing-fields
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.shortmess:append 'c'

local cmp = require 'cmp'
local luasnip = require 'luasnip'
local icons = require 'mini.icons'

cmp.setup {
  sources = {
    {
      name = 'nvim_lsp',
      ---@diagnostic disable-next-line: unused-local
      entry_filter = function(entry, ctx)
        return require('cmp').lsp.CompletionItemKind.Snippet ~= entry:get_kind()
      end,
    },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'path' },
  },

  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }, -- [n]ext item
    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }, -- [p]revious item
    ['<C-y>'] = cmp.mapping(cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }, { 'i', 'c' }), -- Accept ([y]es) completion.
    ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll the documentation window [b]ack
    ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Scroll the documentation window [f]orward

    ['<C-l>'] = cmp.mapping(function() -- <c-l> will move you to the next expansion locations.
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),

    ['<C-h>'] = cmp.mapping(function() -- <c-h> is similar, except moving you backwards.
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
  },

  -- Enable luasnip to handle snippet expansion for nvim-cmp
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },

  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    expandable_indicator = true,
    format = function(entry, vim_item)
      local icon, hl_group = icons.get('lsp', vim_item.kind)
      vim_item.kind = string.format('%s ', icon)
      vim_item.kind_hl_group = hl_group
      --stylua: ignore
      vim_item.menu = ({
        buffer    =  '[Buffer]',
        nvim_lsp  =  '[LSP]',
        luasnip   =  '[SNIP]',
        path      =  '[path]',
      })[entry.source.name]
      return vim_item
    end,
  },

  window = {
    documentation = cmp.config.window.bordered { border = 'rounded' },
    completion = cmp.config.window.bordered {
      col_offset = -2,
      side_padding = 1,
      border = 'rounded',
    },
  },
}
