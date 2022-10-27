" init.vim
"
" @ricalbr

set runtimepath^=$XDG_CONFIG_HOME/nvim
set runtimepath+=$XDG_DATA_HOME/nvim
set runtimepath+=$XDG_CONFIG_HOME/nvim/after

let &packpath = &runtimepath
set packpath+=$XDG_DATA_HOME/nvim/*

lua require('init')

" status line {{{

" status bar colors
autocmd InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=green
autocmd InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
highlight statusline                guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

" Status Line Custom
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^v' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

" Function: return current mode
" abort -> function will abort soon as error detected
function! ModeCurrent() abort
    let l:modecurrent = mode()
    " use get() -> fails safely, since ^V doesn't seem to register
    " 3rd arg is used when return of mode() == 0, which is case with ^V
    " thus, ^V fails -> returns 0 -> replaced with 'V Block'
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

set laststatus=3
set noshowmode
set statusline=
set statusline+=%0*\ %{ModeCurrent()}\                      " current mode
set statusline+=%#LineNr#                                   " transparent line
set statusline+=\ %<%{pathshorten(expand('%:~:p'))}         " filepath
set statusline+=\ %m%r%h%w\ |                               " modified, readonly, helpfile, preview
set statusline+=%=                                          " right side separator
set statusline+=%y\ |                                       " filetype
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}  " encoding
set statusline+=%#LineNr#\ %5p%%\ \ (%l:%3c)\ |            " percentage (row:column) numbers
set statusline+=%0*\ %n\                                    " buffer number
" }}}
