-- text files

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- -- spelling
-- local spell = require 'core.spell'
-- spell()

-- twitter mode
vim.keymap.set('n', '<leader>tw', ':match Error "%>281v.+"<CR>')

-- let s:activatedt = 0
-- function! TwitterMode()
--     if s:activatedt == 0
--         let s:activatedt = 1
--         match Error '\%>281v.\+'
--     else
--         let s:activatedt = 0
--         match none
--     endif
-- endfunction

-- nnoremap <leader>tw :call TwitterMode()<CR>
