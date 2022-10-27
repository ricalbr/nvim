-- vim

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

-- automatically source .vimrc on save
-- augroup Vimrc
--   autocmd!
--   autocmd! bufwritepost vimrc source %
-- augroup END

vim.opt.foldmethod = 'marker'
vim.opt.foldmarker = '{{{,}}}'
vim.opt.foldlevelstart = 0
vim.opt.foldlevel = 0

