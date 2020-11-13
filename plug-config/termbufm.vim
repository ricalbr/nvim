" " if you prefer it opening in a left-right split:
" let g:termbufm_direction_cmd = 'vnew'

" if you prefer it opening in a top-down split:
let g:termbufm_direction_cmd = 'vnew'

let g:termbufm_code_scripts = {
            \ 'python': { 'build': [''],                       'run': ['python %s', '%'] },
            \ 'cpp':    { 'build': ['g++ %s', '%'],            'run': ['./a.out'] },
            \ 'java':   { 'build': ['javac %s', '%'],          'run': ['java %s', '%:r'] },
            \ 'c':      { 'build': ['gcc %s', '%'],            'run': ['./a.out'] },
            \ }

command! TBuild call TermBufMExecCodeScript(&filetype, 'build')
command! TRun call TermBufMExecCodeScript(&filetype, 'run')

nnoremap <silent> <leader>kk :TBuild<CR>
nnoremap <silent> <leader>kl :TRun<CR>

" toggle the window (show/hide) and toggle INSERT mode
nnoremap <silent> <leader>yy :call TermBufMToggle()<CR>i
