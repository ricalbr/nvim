-- markdown

-- markdown specific text format
vim.opt.linebreak = true
vim.opt.formatoptions = vim.opt.formatoptions - 't'

-- spelling
local spell = require 'core.spell'
spell()

-- keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', opts)

-- comment string
vim.opt.commentstring = '<!-- %s -->'
