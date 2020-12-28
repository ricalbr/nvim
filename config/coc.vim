" list of the extensions to make sure are always installed
let g:coc_global_extensions = [
            \'coc-actions',
            \'coc-clangd',
            \'coc-cmake',
            \'coc-css',
            \'coc-cssmodules',
            \'coc-explorer',
            \'coc-fzf-preview',
            \'coc-git',
            \'coc-highlight',
            \'coc-html',
            \'coc-json',
            \'coc-julia',
            \'coc-lists',
            \'coc-marketplace',
            \'coc-pairs',
            \'coc-prettier',
            \'coc-python',
            \'coc-snippets',
            \'coc-syntax',
            \'coc-tslint',
            \'coc-tsserver',
            \'coc-vimtex',
            \'coc-yaml',
            \'coc-yank'
            \]

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" use tab to navigate snippet placeholders
function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
		  \ pumvisible() ? "\<C-n>" :
		  \ <SID>check_back_space() ? "\<TAB>" :
		  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"Explorer
map <leader>n :CocCommand explorer<CR>

" Use enter to accept snippet expansion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" multi cursor shortcuts
nmap <silent> <C-a> <Plug>(coc-cursors-word)
xmap <silent> <C-a> <Plug>(coc-cursors-range)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" other stuff
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>o :OR <CR>

" jump stuff
nmap <leader>jd <Plug>(coc-definition)
nmap <leader>jy <Plug>(coc-type-definition)
nmap <leader>ji <Plug>(coc-implementation)
nmap <leader>jr <Plug>(coc-references)

" other coc actions
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <leader>a :CocCommand actions.open<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

