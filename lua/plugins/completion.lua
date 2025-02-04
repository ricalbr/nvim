return {
    {
        'echasnovski/mini.snippets',
        dependencies = 'rafamadriz/friendly-snippets',
        event = 'InsertEnter',
        opts = function()
            local snippets = require 'mini.snippets'
            return {
                snippets = {
                    snippets.gen_loader.from_file '$XDG_CONFIG_HOME/nvim/snippets/cpp.json',
                    snippets.gen_loader.from_lang(),
                },
            }
        end,
    },

    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'abeldekat/cmp-mini-snippets',
        },
        config = function()
            require 'plugins.config.completion'
        end,
    },
}
