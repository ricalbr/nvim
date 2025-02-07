return {
    {
        'echasnovski/mini.nvim',
        version = false,
        event = 'BufReadPre',

        config = function()
            require('mini.ai').setup()
            require('mini.bracketed').setup()
            require('mini.comment').setup()
            require('mini.icons').setup { lsp = { ['snippet'] = { glyph = '' } } }
            require('mini.jump').setup()
            require('mini.pairs').setup()
            require('mini.tabline').setup { show_icons = false }
            -- {{{ mini.trailspace
            require('mini.trailspace').setup()
            vim.api.nvim_create_autocmd('BufWritePre', {
                callback = function()
                    require('mini.trailspace').trim()
                end,
            })
            -- }}}
            -- {{{ mini.indentscope
            require('mini.indentscope').setup {
                symbol = '│',
                draw = {
                    delay = 30,
                    animation = function()
                        return 0
                    end,
                },
            }
            -- }}}
            -- {{{ mini.diff
            require('mini.diff').setup {
                view = {
                    style = 'sign',
                    signs = { add = '▌', change = '▌', delete = '▌' },
                },
                mappings = { apply = 'ha', reset = 'hr' },
            }
            -- toggle git diff
            vim.keymap.set('n', '<Leader>gf', [[:<C-u>lua MiniDiff.toggle_overlay()<CR>]], { silent = true, desc = 'Toggle Git diff' })
            -- }}}
            -- {{{ mini.surround
            require('mini.surround').setup {
                -- stylua: ignore
                mappings = {
                    add             =  'ys',  --  defult  'sa'
                    delete          =  'ds',  --  defult  'sd'
                    find            =  '',    --  defult  'sf'
                    find_left       =  '',    --  defult  'sF'
                    highlight       =  '',    --  defult  'sh'
                    replace         =  'cs',  --  defult  'sr'
                    update_n_lines  =  '',    --  defult  'sn'
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
            -- }}}
            -- {{{ mini.clue
            local miniclue = require 'mini.clue'
            miniclue.setup {
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },
                },

                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
                -- window = {
                --     config = { anchor = 'SW', row = 'auto', col = 0 },
                -- },
            }
            -- }}}
            MiniIcons.mock_nvim_web_devicons()
        end,
    },
}
