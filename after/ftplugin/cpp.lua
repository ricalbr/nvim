-- c++
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.fileformat = 'unix'
vim.opt.foldlevelstart = 99

local opts = { noremap = true, silent = true }

-- make program (compile with sanitizers)
vim.opt.makeprg = 'g++ -std=c++17 -Wshadow -Wall -g -I include % -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG -o %:r'
vim.keymap.set('n', '<F6>', '<cmd> make<CR>', opts)
vim.keymap.set('i', '<F6>', '<Esc> <cmd>make <CR>', opts)

-- compile with -O2 flag (optimized)
vim.keymap.set('n', '<F7>', ':w <bar> !g++ -std=c++17 -Wshadow -Wall -O2 -Wno-unused-result -I include % -o %:r <CR>', opts)
vim.keymap.set('i', '<F7>', '<Esc> :w <bar> !g++ -std=c++17 -Wshadow -Wall -O2 -Wno-unused-result -I include % -o %:r <CR>', opts)

-- execute
vim.keymap.set('n', '<F8>', '<cmd> !./%:r <CR>', opts)
vim.keymap.set('i', '<F8>', '<Esc> <cmd>!./%:r <CR>', opts)

-- debugging
vim.keymap.set('n', '<F9>', '<cmd> gdb ./%:r<CR>', opts)

-- NB: to remove/change these mappings use :mapclear <buffer>
--     see also :h map-<buffer>
