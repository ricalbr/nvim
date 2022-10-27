require('user.plugins')
require('user.opts')
require('user.binds')

require('user.cmp')
require('user.lsp')
require('user.telescope')
require('user.treesitter')

vim.cmd('let g:material_terminal_italics = 1')
vim.cmd("let g:material_theme_style = 'darker-community'")
vim.cmd('colo material')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
