" C++
" Build for debugging
nnoremap <buffer> <F7> :w <bar> !g++ -std=c++11 -Wall -m64 -g -I include % -o %:r <CR>
nnoremap <buffer> <F8> :!./%:r<CR>
" Debugging
nnoremap <buffer> <F9> :!gdb ./%:r<CR>
"   Release
nnoremap <buffer> <F5> :w <bar> !g++ -std=c++14 -m64 -O3 -I include % -o %:r <CR>
