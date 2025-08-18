require('nvim-treesitter.configs').setup(
    {
        ensure_installed = { 'bash', 'c', 'cpp', 'gitignore', 'json', 'latex', 'lua', 'markdown', 'markdown_inline', 'matlab', 'python', 'query', 'regex', 'vim', 'vimdoc', 'yaml', 'zig' },
        indent = { enable = true },
        highlight = { enable = true, },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<C-space>',
                node_incremental = '<C-space>',
                scope_incremental = false,
                node_decremental = '<bs>',
            },
        },
    })
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
