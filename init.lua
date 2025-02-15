-- init.lua
-- @ricalbr

-- config {{{
-- set <space> as the leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- general
vim.g.editorconfig = false
vim.opt.laststatus = 2
vim.opt.clipboard = 'unnamed'
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.mouse = 'a'
vim.cmd 'filetype plugin indent on'
require 'core.filetypes'

-- numbers
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ruler and indenting
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.linebreak = true
vim.opt.signcolumn = 'yes'
vim.opt.fillchars = 'eob: '
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- editing
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.infercase = true
vim.opt.smartindent = true
vim.opt.completeopt = 'menuone,noselect'
vim.opt.virtualedit = 'block'
vim.opt.formatoptions = 'qjl1'

-- neovim version dependent
if vim.fn.has 'nvim-0.9' == 1 then
    vim.opt.shortmess:append 'WcC'
    vim.opt.splitkeep = 'screen'
else
    vim.opt.shortmess:append 'Wc'
end

if vim.fn.has 'nvim-0.10' == 0 then
    vim.opt.termguicolors = true
end

-- some opinioneted extra ui options
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.winblend = 10
vim.opt.listchars = 'tab:> ,extends:…,precedes:…,nbsp:␣'
vim.opt.list = true
vim.opt.foldlevelstart = 99

-- enable syntax highlighting if it wasn't already (as it is time consuming)
if vim.fn.exists 'syntax_on' ~= 1 then
    vim.cmd [[syntax enable]]
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == 'Windows_NT'
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin' .. (is_windows and ';' or ':') .. vim.env.PATH

-- add python interpreper
vim.g.python3_host_prog = '$HOME/.venv/nvim/bin/python3'

-- keymaps and autocomands
require 'core.keymaps'
require 'core.autocmd'

vim.loader.enable()
--}}}

-- lazy.nvim {{{
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- lazy config {{{
require('lazy').setup({ import = 'plugins' }, {
    performance = {
        cache = { enabled = true },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            disabled_plugins = {
                '2html_plugin',
                'getscript',
                'getscriptPlugin',
                'gzip',
                'logiPat',
                -- 'matchit',
                -- 'matchparen',
                'netrw',
                'netrwFileHandlers',
                'netrwPlugin',
                'netrwSettings',
                'rplugin',
                'rrhelper',
                'spellfile',
                'tar',
                'tarPlugin',
                'tohtml',
                'tutor',
                'tutor_mode_plugin',
                'vimball',
                'vimballPlugin',
                'zip',
                'zipPlugin',
            },
        },
    },
    change_detection = { notify = false },
    rocks = { enabled = false },
})
-- }}}
-- }}}
