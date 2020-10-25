let g:semshi#error_sign	= v:false       " let ms python lsp handle this

" python renaming
autocmd FileType python nnoremap <leader>rn :Semshi rename <CR>