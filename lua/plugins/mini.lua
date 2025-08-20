require('mini.ai').setup()
require('mini.align').setup()
require('mini.jump').setup()
require('mini.pairs').setup()
require('mini.tabline').setup { show_icons = false }
require('mini.trailspace').setup()
require('mini.icons').setup()
-- -- {{{ mini.snippets
-- require('mini.snippets').setup {
--     -- dependencies = 'rafamadriz/friendly-snippets',
--     opts = function()
--         local snippets = require 'mini.snippets'
--         return {
--             snippets = {
--                 snippets.gen_loader.from_file '$XDG_CONFIG_HOME/nvim/snippets/cpp.json',
--                 snippets.gen_loader.from_lang(),
--             },
--         }
--     end,
-- }
-- -- }}}
-- {{{ mini.indentscope
require('mini.indentscope').setup {
    symbol = '│',
    draw = {
        delay = 30,
        animation = function() return 0 end,
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
-- toggle git diff,
vim.keymap.set('n', '<Leader>gf', [[:<C-u>lua MiniDiff.toggle_overlay()<CR>]],
    { silent = true, desc = 'Toggle Git diff' })
-- }}}
-- {{{ mini.surround
require('mini.surround').setup {
    mappings = {
        add            = 'ys', --  default  'sa'
        delete         = 'ds', --  default  'sd'
        find           = '',   --  default  'sf'
        find_left      = '',   --  default  'sF'
        highlight      = '',   --  default  'sh'
        replace        = 'cs', --  default  'sr'
        update_n_lines = '',   --  default  'sn'
        suffix_last    = '',
        suffix_next    = '',
    },
    search_method = 'cover_or_next',
}

-- remap adding surrounding to visual mode selection
vim.keymap.del('x', 'ys')
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

-- make special mapping for "add surrounding for line"
vim.keymap.set('n', 'yss', 'ys_', { remap = true })
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
                { hl = mode_hl,  strings = { mode:upper() } },
                '%<', -- Mark general truncate point
                { hl = 'Normal', strings = { branch_name(), '    ', lsp() } },
                '%=', -- End left alignment
                { hl = 'Normal', strings = { lineinfo(), filetype(), fileencoding() } },
            }
        end,
    },
}
-- }}}
