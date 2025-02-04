---@diagnostic disable-next-line: missing-fields
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.shortmess:append 'c'

local cmp = require 'cmp'
local icons = require 'mini.icons'

cmp.setup {
    sources = {
        { name = 'nvim_lsp' },
        { name = 'mini_snippets' },
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
    },

    -- mini.snippets to handle snippet expansion for nvim-cmp
    snippet = {
        expand = function(args)
            local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            insert { body = args.body }
            cmp.resubscribe { 'TextChangedI', 'TextChangedP' }
            require('cmp.config').set_onetime { sources = {} }
        end,
    },

    formatting = {
        fields = { 'abbr', 'kind' }, -- eventually add 'menu'
        expandable_indicator = true,
        format = function(entry, vim_item)
            local icon, hl_group = icons.get('lsp', vim_item.kind)
            vim_item.kind = string.format('%s  (%s)  ', icon, vim_item.kind)
            vim_item.kind_hl_group = hl_group
            --stylua: ignore
            vim_item.menu = ({
                buffer    =  '[BUF]',
                nvim_lsp  =  '[LSP]',
                luasnip   =  '[SNP]',
                path      =  '[PTH]',
            })[entry.source.name]
            return vim_item
        end,
    },

    window = {
        documentation = cmp.config.window.bordered { winhighlight = 'FloatBorder:Comment' },
        completion = cmp.config.window.bordered { winhighlight = 'FloatBorder:Comment' },
    },
}
