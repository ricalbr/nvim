-- init.lua
-- @ricalbr

-- set <space> as the leader key
--  NOTE: must happen before plugins are required (otherwise wrong leader will be used)
vim.keymap.set({ 'n', 'v' }, '<Space>', '', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'core'
require 'core.keymaps'
vim.loader.enable()

-- lazy.nvim
-- bootstrap {{{
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
-- }}}
-- lazy config {{{
require('lazy').setup({ import = 'config/plugins' }, {
  performance = {
    cache = {
      enabled = true,
    },
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
  change_detection = {
    notify = false,
  },
})
-- }}}

-- custom filetpes {{{
vim.filetype.add { extensions = {
  pgm = 'gcode',
  gcode = 'gcode',
  g = 'gcode',
  ngc = 'gcode',
} }
-- vim.cmd 'filetype plugin on'
-- }}}
