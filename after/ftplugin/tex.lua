-- LaTeX

-- tex specific text format
vim.opt.linebreak = true
-- set fo-=t

-- set compiler
vim.opt.compiler = 'tex'

-- set spell
local spell = require 'core.spell'
spell()

-- keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', opts)

-- generate the document and open pdf
vim.keymap.set('i', '<F7>', '<Esc> <cmd>w | :Make % <CR>', opts)
vim.keymap.set('n', '<F7>', '<cmd>w | :Make % <CR>', opts)

-- compilation using pdflatex
vim.keymap.set('i', '<F8>', '<Esc> <cmd>w | :! pdflatex % <CR><CR>', opts)
vim.keymap.set('n', '<F8>', '<cmd>w | :! pdflatex % <CR><CR>', opts)
vim.keymap.set('n', '<F8>', ':w | :Make % <CR>', opts)

-- open document
vim.keymap.set('n', '<leader>o', ':! zathura %<.pdf & <CR><CR>', opts)
