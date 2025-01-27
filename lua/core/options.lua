local opt = vim.opt
local g = vim.g

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

---@diagnostic disable-next-line: missing-fields
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

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == 'Windows_NT'
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin' .. (is_windows and ';' or ':') .. vim.env.PATH

-- add python interpreper
vim.g.python3_host_prog = '$HOME/.venv/nvim/bin/python3'
