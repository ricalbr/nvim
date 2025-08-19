-- init.lua @ricalbr

-- set <space> as the leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- general
vim.opt.clipboard = 'unnamed'
vim.opt.undofile = true
vim.opt.mouse = 'a'
vim.opt.winborder = 'rounded'
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.completeopt = 'menu,menuone,popup,fuzzy,noinsert'

-- plugins
vim.pack.add({
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/echasnovski/mini.nvim' },
    { src = 'https://github.com/ibhagwan/fzf-lua' },
    -- { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
})

require 'mason'.setup()
require 'fzf-lua'.setup()
require 'plugins.mini'
require 'plugins.oil'

-- keymaps and autocmds
require 'keymaps'
require 'autocmd'

vim.lsp.enable({ 'lua_ls', 'clangd', 'codespell', 'prettier', 'pyright', 'ltex-ls-plus' })
-- require('nvim-treesitter.configs').setup({
--     ensure_installed = { 'lua', 'python', 'c', 'cpp' },
--     highlight = { enable = true },
--     indent = { enable = true },
-- })
