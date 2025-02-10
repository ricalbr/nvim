return {
    {
        'ibhagwan/fzf-lua',
        cmd = 'FzfLua',
        opts = {
            'border-fused',
            fzf_opts = { ['--wrap'] = true },
            previewers = {
                builtin = {
                    syntax_limit_b = -102400, -- 100KB limit on highlighting files
                },
            },
            winopts = {
                preview = {
                    default = 'bat',
                    title = false,
                    border = 'none',
                },
                treesitter = false,
            },
            grep = {
                rg_glob = true,
                rg_opts = '--color=never --no-heading --with-filename --line-number --column --smart-case --hidden --glob=!.git/',
            },
            defaults = {
                git_icons = false,
                file_icons = false,
                color_icons = false,
                formatter = 'path.filename_first',
            },
        },
    },
}
