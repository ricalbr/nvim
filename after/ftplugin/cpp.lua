-- c++
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.fileformat = 'unix'
vim.opt.foldlevelstart = 99

-- build and execute
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<F7>', ':w <bar> !g++ -std=c++17 -Wall -m64 -g -I include % -o %:r <CR>', opts)

vim.keymap.set('i', '<F7>', '<Esc>:w <bar> !g++ -std=c++17 -Wall -m64 -g -I include % -o %:r <CR>', opts)
vim.keymap.set('i', '<F8>', '<Esc>:!./%:r<CR>', opts)

-- compile with -O2 flag (optimized)
vim.keymap.set('n', '<F7>', ':w <bar> !g++ -std=c++17 -Wshadow -Wall -O2 -Wno-unused-result -I include % -o %:r <CR>', opts)
vim.keymap.set('i', '<F7>', '<Esc> :w <bar> !g++ -std=c++17 -Wshadow -Wall -O2 -Wno-unused-result -I include % -o %:r <CR>', opts)
-- compile with sanitizers
vim.keymap.set(
  'n',
  '<F9>',
  ':w <bar> !g++ -std=c++17 -Wshadow -Wall -o %:r -g -I include % -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG <CR>',
  opts
)
vim.keymap.set(
  'i',
  '<F9>',
  '<Esc> :w <bar> !g++ -std=c++17 -Wshadow -Wall -o %:r -g -I include % -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG <CR>',
  opts
)

-- execute
vim.keymap.set('i', '<F8>', '<Esc>:!./%:r', opts)

-- debugging
vim.keymap.set('n', '<F9>', ':!gdb ./%:r<CR>', opts)

-- NB: to remove/change these mappings use :mapclear <buffer>
--     see also :h map-<buffer>
