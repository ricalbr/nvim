-- LaTeX

" tex specific text format
set linebreak
set fo-=t

" set compiler
compiler tex

"correcting spelling mistakes on the fly
setlocal spell
set spelllang=en_gb,it
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" generate the document and open pdf
inoremap <F7> <Esc> :w \| :Make % <CR>
nnoremap <F7> :w \| :Make % <CR>

" compilation using pdflatex
inoremap <F8> <Esc> :w \| :! pdflatex % <CR><CR>
nnoremap <F8> :w \| :! pdflatex % <CR><CR>

" open document
noremap <leader>o :! zathura %<.pdf & <CR><CR>
