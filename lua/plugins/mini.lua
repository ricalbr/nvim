return {
    {
        'echasnovski/mini.nvim',
        version = false,
        event = 'BufReadPre',

        --stylua: ignore
        config = function()
            require('mini.ai').setup()
            require('mini.bracketed').setup()
            require('mini.comment').setup()
            require('mini.indentscope').setup { draw = { animation = function() return 0 end } }
            require('mini.icons').setup { lsp = { ['snippet'] = { glyph = '' } } }
            require('mini.jump').setup()
            require('mini.pairs').setup()
            require('mini.tabline').setup { show_icons = false }
            require('mini.trailspace').setup()
            -- require('mini.statusline').setup()
            -- require('mini.pick').setup()
            require('mini.diff').setup {
                view = {
                    style = 'sign',
                    signs = { add = '▌', change = '▌', delete = '▌' },
                },
                mappings = { apply = 'ha', reset = 'hr' },
            }
            require('mini.surround').setup {
                mappings = {
                    add             =  'ys', --  defult  'sa'
                    delete          =  'ds', --  defult  'sd'
                    find            =  '', --  defult  'sf'
                    find_left       =  '', --  defult  'sF'
                    highlight       =  '', --  defult  'sh'
                    replace         =  'cs', --  defult  'sr'
                    update_n_lines  =  '', --  defult  'sn'
                    suffix_last     =  '',
                    suffix_next     =  '',
                },
                search_method = 'cover_or_next',
            }

            -- remap adding surrounding to visual mode selection
            vim.keymap.del('x', 'ys')
            vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

            -- make special mapping for "add surrounding for line"
            vim.keymap.set('n', 'yss', 'ys_', { remap = true })

            MiniIcons.mock_nvim_web_devicons()
        end,
    },

    {
        'takac/vim-hardtime',
        cmd = 'HardTimeOn',
    },
}
