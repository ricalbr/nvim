return {
    {
        'echasnovski/mini.nvim',
        version = false,
        event = 'BufReadPre',
        config = function()
            require('mini.ai').setup()
            require('mini.align').setup()
            require('mini.bracketed').setup()
            require('mini.comment').setup()
            require('mini.jump').setup()
            require('mini.pairs').setup()
            require('mini.tabline').setup { show_icons = false }
            require('mini.trailspace').setup()
            -- {{{ mini.icons
            local icons = require 'mini.icons'
            icons.setup { lsp = { ['snippet'] = { glyph = '' } } }
            icons.mock_nvim_web_devicons()
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
                    signs = { add = '▌', change = '▌', delete = '▸' },
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
                    add             =  'ys',  --  default  'sa'
                    delete          =  'ds',  --  default  'sd'
                    find            =  '',    --  default  'sf'
                    find_left       =  '',    --  default  'sF'
                    highlight       =  '',    --  default  'sh'
                    replace         =  'cs',  --  default  'sr'
                    update_n_lines  =  '',    --  default  'sn'
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
            -- {{{ mini.statusline
            require('mini.statusline').setup {
                content = {
                    active = function()
                        local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }

                        local function lineinfo()
                            if vim.bo.filetype == 'alpha' then
                                return ''
                            end
                            return ' Ln %l, Col %c '
                        end

                        local function branch_name()
                            local branch = vim.fn.system "git branch --show-current 2> /dev/null | tr -d '\n'"
                            if branch ~= '' then
                                return ' ' .. branch
                            else
                                return ''
                            end
                        end

                        local function lsp()
                            local count = {}
                            local levels = {
                                errors = 'Error',
                                warnings = 'Warn',
                                info = 'Info',
                                hints = 'Hint',
                            }

                            for k, level in pairs(levels) do
                                count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
                            end

                            local errors = ' ' .. count['errors'] .. ' '
                            local warnings = ' ' .. count['warnings'] .. ' '
                            local hints = ''
                            local info = ''

                            if count['hints'] ~= 0 then
                                hints = ' ' .. count['hints'] .. ' '
                            end
                            if count['info'] ~= 0 then
                                info = ' ' .. count['info'] .. ' '
                            end

                            return errors .. warnings .. hints .. info
                        end

                        local function fileencoding()
                            return string.format(' %s ', vim.bo.fileencoding):upper()
                        end

                        local function filetype()
                            return string.format(' %s ', vim.bo.filetype):upper()
                        end

                        return MiniStatusline.combine_groups {
                            { hl = mode_hl, strings = { mode:upper() } },
                            '%<', -- Mark general truncate point
                            { hl = 'Normal', strings = { branch_name(), '    ', lsp() } },
                            '%=', -- End left alignment
                            { hl = 'Normal', strings = { lineinfo(), filetype(), fileencoding() } },
                        }
                    end,
                },
            }
            -- }}}
        end,
    },
}
