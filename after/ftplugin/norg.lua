-- norg

-- basic settings
vim.opt.linebreak = true
vim.opt.formatoptions = vim.opt.formatoptions - 't'
vim.opt.fileformat = 'unix'
vim.opt.conceallevel = 2
vim.opt.spellcapcheck = ''

-- keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', opts)
