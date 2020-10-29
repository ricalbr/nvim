" " Navigate snippet placeholders using tab
" let g:coc_snippet_next = '<Tab>'
" let g:coc_snippet_prev = '<S-Tab>'

" list of the extensions to make sure are always installed
let g:coc_global_extensions = [
            \'coc-actions',
            \'coc-pairs',
            \'coc-json',
            \'coc-lists',
            \'coc-snippets',
            \'coc-python',
            \'coc-clangd',
            \'coc-cmake',
            \'coc-julia',
            \'coc-prettier',
            \'coc-syntax',
            \'coc-git',
            \'coc-marketplace',
            \'coc-highlight',
            \'coc-vimtex',
            \]

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
