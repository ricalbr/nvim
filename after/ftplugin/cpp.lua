-- c++
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.fileformat = 'unix'
vim.opt.foldlevelstart = 99

-- build and execute
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<F7>', ':w <bar> !g++ -std=c++11 -Wall -m64 -g -I include % -o %:r <CR>', opts)
vim.keymap.set('n', '<F8>', ':!.%:r<CR>', opts)
-- debugging
vim.keymap.set('n', '<F9>', ':!gdb ./%:r<CR>', opts)

-- NB: to remove/change these mappings use :mapclear <buffer>
--     see also :h map-<buffer>
