return {
    {
        'nvim-treesitter/nvim-treesitter',
        tag = 'v0.9.3', -- last version compatible with Nvim 0.9
        event = { 'BufReadPre', 'BufNewFile' },
        build = ':TSUpdate',
        branch = 'main',
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('nvim-treesitter.configs').setup {
                indent = { enable = true },
                highlight = {
                    enable = true,
                    ---@diagnostic disable-next-line: unused-local
                    disable = function(lang, buf)
                        local max_filesize = 5 * 1024 * 1024 -- 5 MB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<C-space>',
                        node_incremental = '<C-space>',
                        scope_incremental = false,
                        node_decremental = '<bs>',
                    },
                },
                ensure_installed = {
                    'bash',
                    'c',
                    'cpp',
                    'gitignore',
                    'html',
                    'javascript',
                    'json',
                    'latex',
                    'lua',
                    'markdown',
                    'markdown_inline',
                    'python',
                    'query',
                    'vim',
                    'vimdoc',
                    'yaml',
                    'zig',
                },
            }
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end,
    },
}
