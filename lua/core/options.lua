vim.g.editorconfig = false
vim.opt.laststatus = 2 -- global statusline
vim.opt.showmode = false

-- opt.clipboard = ''
require 'core.clipboard'
vim.opt.cursorline = false

-- indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

---@diagnostic disable-next-line: missing-fields
vim.opt.fillchars = { eob = ' ' }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = 'a'
vim.opt.pumheight = 10 -- limit completion items
vim.opt.foldlevelstart = 99

-- numbers
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true
vim.opt.ruler = false

-- disable nvim intro
vim.opt.shortmess:append 'sI'

vim.opt.signcolumn = 'yes'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 400
vim.opt.updatetime = 250
vim.opt.undofile = true
vim.g.swapfile = false

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == 'Windows_NT'
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin' .. (is_windows and ';' or ':') .. vim.env.PATH

-- add python interpreper
vim.g.python3_host_prog = '$HOME/.venv/nvim/bin/python3'
