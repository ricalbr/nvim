-- init.lua
-- @ricalbr

-- config {{{
require 'core.keymaps'
require 'core.autocmd'
require 'core.options'
require 'core.filetypes'
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

-- -- colorscheme {{{
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#000000' })
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#006400' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#FFCC00' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#8B0000' })
    vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitSignsDelete' })
    vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'GitSignsDelete' })
    vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#585858', fg = '#DFDF87' })
    vim.api.nvim_set_hl(0, 'Visual', { link = 'Folded' })
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#000000' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#000000' })
  end,
})
vim.cmd.colorscheme 'habamax'
-- -- }}}
