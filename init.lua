-- init.lua @ricalbr

-- set <space> as the leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- general
vim.g.clipboard = 'osc52'
vim.o.undofile = true
vim.o.mouse = 'a'
vim.o.winborder = 'rounded'
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smartindent = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.signcolumn = 'yes'
vim.o.pumheight = 10
vim.o.completeopt = 'menu,popup,fuzzy,noinsert'

-- plugins
vim.pack.add({
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/echasnovski/mini.nvim' },
    { src = 'https://github.com/ibhagwan/fzf-lua' },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = "https://github.com/Saghen/blink.cmp",                version = "v1.6.0" },
    { src = 'https://github.com/rafamadriz/friendly-snippets' }
})

require 'mason'.setup()
require 'fzf-lua'.setup()
require 'plugins.mini'
require 'plugins.oil'
vim.cmd('colorscheme spring')

-- keymaps and autocmds
require 'keymaps'
require 'autocmd'

-- blink
vim.lsp.enable({ 'lua_ls', 'clangd', 'ruff', 'tinymist' })
require("blink.cmp").setup({
    {
        keymap = { preset = 'default' },
        appearance = { nerd_font_variant = 'mono' },
        completion = { documentation = { auto_show = false } },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "rust_prefered" }
    },
    opts_extend = { "sources.default" }
})

-- treesitter
require('nvim-treesitter.configs').setup({
    ensure_installed = { 'lua', 'python', 'c', 'cpp', 'typst' },
    highlight = { enable = true },
    indent = { enable = true },
})
