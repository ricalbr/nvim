-- init.lua @ricalbr

-- set <space> as the leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- general
vim.o.clipboard = 'unnamed'
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
vim.o.completeopt = 'menu,menuone,popup,fuzzy,noinsert'

-- plugins
vim.pack.add({
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/echasnovski/mini.nvim' },
    { src = 'https://github.com/ibhagwan/fzf-lua' },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
})

require 'mason'.setup()
require 'fzf-lua'.setup()
require 'plugins.mini'
require 'plugins.oil'
vim.cmd('colorscheme spring')

-- keymaps and autocmds
require 'keymaps'
require 'autocmd'

vim.lsp.enable({ 'lua_ls', 'clangd', 'pyright', 'tinymist' })
require('nvim-treesitter.configs').setup({
    ensure_installed = { 'lua', 'python', 'c', 'cpp', 'typst' },
    highlight = { enable = true },
    indent = { enable = true },
})
