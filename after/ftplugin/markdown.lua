-- markdown

-- markdown specific text format
vim.opt.linebreak = true
vim.opt.formatoptions = vim.opt.formatoptions - 't'

-- keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', opts)

-- commment string
vim.opt.commentstring = '<!-- %s -->'
