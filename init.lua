-- init.lua
-- @ricalbr

-- config {{{
require 'core.keymaps'
require 'core.autocmd'
require 'core.options'
require 'core.filetypes'

vim.cmd.colorscheme 'habamax'
vim.loader.enable()
-- }}}

-- lazy.nvim {{{
-- bootstrap
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

require('lazy').setup({ import = 'plugins' }, {
  -- debug = true,
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
  rocks = {
    enabled = false,
  },
})
-- }}}
