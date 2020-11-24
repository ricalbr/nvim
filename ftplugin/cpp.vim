" C++

" C++ commentstring
autocmd FileType cpp setlocal commentstring=//\ %s

" Build for debugging
noremap <buffer> <F7> :w <bar> !g++ -std=c++11 -Wall -m64 -g -I include % -o %:r <CR>
noremap <buffer> <F8> :!./%:r<CR>
" Debugging
noremap <buffer> <F9> :!gdb ./%:r<CR>
" Release
noremap <buffer> <F5> :w <bar> !g++ -std=c++14 -m64 -O3 -I include % -o %:r <CR>
