return {
    {
        'stevearc/oil.nvim',
        cmd = 'Oil',
        -- keys = {
        --   { '-', [[<cmd>lua require('oil').open_float(".")<CR>]], desc = 'Open parent directory' },
        -- },
        config = function()
            require('oil').setup {
                columns = { 'icon' },
                keymaps = {
                    ['<C-h>'] = false,
                    ['<M-h>'] = 'actions.select_split',
                    ['<M-v>'] = 'actions.select_vsplit',
                    ['h'] = 'actions.parent',
                    ['l'] = 'actions.select',
                    ['p'] = 'actions.preview',
                },
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                    is_always_hidden = function(name, _)
                        return name == '..' or name == '.git'
                    end,
                },
                float = {
                    padding = 2,
                    max_width = 0.2,
                    max_height = 0,
                    border = 'rounded',
                    win_options = {
                        winblend = 0,
                    },
                    override = function(conf)
                        conf.anchor = 'NE'
                        conf.row = 0
                        conf.col = 4
                        return conf
                    end,
                },
            }
        end,
    },
}
