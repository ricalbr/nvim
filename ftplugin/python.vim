map <buffer> <F4> :CocCommand python.setInterpreter<CR>
map <buffer> <F7> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
imap <buffer> <F7> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
