-- python

-- basic settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.encoding = 'utf-8'
vim.opt.fileformat = 'unix'
vim.opt.textwidth = 120
vim.wo.colorcolumn = 121
-- vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 99

-- mappings
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<F5>', ':update <CR>:exec "!python" shellescape(@%, 1)<CR>', opts)
vim.keymap.set('i', '<F5>', '<ESC> :update <CR>:exec "!python" shellescape(@%, 1)<CR>', opts)

