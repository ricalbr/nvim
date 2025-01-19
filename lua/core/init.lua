local opt = vim.opt
local g = vim.g

-- options {{{
g.editorconfig = false
opt.laststatus = 3 -- global statusline
opt.showmode = false

-- opt.clipboard = ''
require 'core.clipboard'
opt.cursorline = false

-- indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = ' ' }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = 'a'
opt.pumheight = 10 -- limit completion items

-- numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false

-- disable nvim intro
opt.shortmess:append 'sI'

opt.signcolumn = 'yes'
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
g.swapfile = false

-- folding options
opt.foldlevelstart = 99

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append '<>[]hl'

-- avoid loading unwanted plugins in vim/vimfiles
vim.cmd 'set rtp-=/usr/share/vim/vimfiles'

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == 'Windows_NT'
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin' .. (is_windows and ';' or ':') .. vim.env.PATH

-- add python interpreper
vim.g.python3_host_prog = '$HOME/.venv/nvim/bin/python'
-- }}}

-- autocmds {{{
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local general_settings = vim.api.nvim_create_augroup('General settings', { clear = true })

-- dont list quickfix buffers
autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.opt_local.buflisted = false
  end,
  group = general_settings,
})

-- map q to :close for utility buffers
autocmd({ 'FileType' }, {
  pattern = {
    'netrw',
    'Jaq',
    'qf',
    'git',
    'help',
    'man',
    'lspinfo',
    'oil',
    'spectre_panel',
    'lir',
    'DressingSelect',
    'tsplayground',
    '',
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
  group = general_settings,
})

-- warn if buffer has been modified outside of vim
autocmd({ 'BufWinEnter' }, {
  pattern = { '*' },
  callback = function()
    vim.cmd 'checktime'
  end,
  group = general_settings,
})

-- autocmd({ 'CursorHold' }, {
--   callback = function()
--     local status_ok, luasnip = pcall(require, 'luasnip')
--     if not status_ok then
--       return
--     end
--     if luasnip.expand_or_jumpable() then
--       -- ask maintainer for option to make this silent
--       -- luasnip.unlink_current()
--       vim.cmd [[silent! lua require("luasnip").unlink_current()]]
--     end
--   end,
--   group = general_settings,
-- })

-- remove trailing white spaces on save
local TrimWhiteSpaceGrp = augroup('TrimWhiteSpaceGrp', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})

-- highlight on yank
local highlight_group = augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- go to last location when opening a buffer
autocmd('BufReadPost', { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]], group = general_settings })

-- don't auto comment new line
autocmd({ 'BufWinEnter' }, {
  callback = function()
    vim.cmd 'set formatoptions-=cro'
  end,
  group = general_settings,
})

-- enable spell checking for certain file types
autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.txt', '*.md', '*.tex' },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = 'en,it'
  end,
  group = general_settings,
})
-- }}}

-- command {{{
-- overload q and w command
vim.api.nvim_command 'command! Q q'
vim.api.nvim_command 'command! W w'
vim.api.nvim_command 'command! Wq wq'

-- write file with sudo
vim.cmd.cnoreabbrev { 'w!!', 'w !sudo tee > /dev/null %<CR>' }
-- }}}
