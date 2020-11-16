map <buffer> <F4> :CocCommand python.setInterpreter<CR>
map <buffer> <F7> :w<CR>:CocCommand python.execInTerminal<CR>
map <buffer> <leader><F7> :only!<CR>
imap <buffer> <F7> <esc>:w<CR>:CocCommand python.execInTerminal<CR>
