-- python

-- basic settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.fileformat = 'unix'
vim.opt.textwidth = 120
-- vim.wo.colorcolumn = 121
-- vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 99

-- mappings
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<F7>', ':update <CR>:exec "!python3" shellescape(@%, 1)<CR>', opts)
vim.keymap.set('i', '<F7>', '<ESC> :update <CR>:exec "!python3" shellescape(@%, 1)<CR>', opts)
