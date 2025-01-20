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
local function agroup(name)
  return vim.api.nvim_create_augroup('lazynvim_' .. name, { clear = true })
end

-- dont list quickfix buffers
autocmd('FileType', {
  group = agroup 'quickfix',
  pattern = 'qf',
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- map q to :close for utility buffers
autocmd({ 'FileType' }, {
  group = agroup 'close_with_q',
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
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- warn if buffer has been modified outside of vim
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = agroup 'checktime',
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
})

-- -- remove trailing white spaces on save
-- local TrimWhiteSpaceGrp = augroup('TrimWhiteSpaceGrp', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   command = [[:%s/\s\+$//e]],
--   group = TrimWhiteSpaceGrp,
-- })

-- highlight on yank
autocmd('TextYankPost', {
  group = agroup 'highlight_yank',
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- go to last loc when opening a buffer
autocmd('BufReadPost', {
  group = agroup 'last_loc',
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- don't auto comment new line
autocmd({ 'BufWinEnter' }, {
  group = agroup 'no_comment_newline',
  callback = function()
    vim.cmd 'set formatoptions-=cro'
  end,
})

-- enable spell checking for certain file types
autocmd('FileType', {
  group = agroup 'wrap_spell',
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
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
