"" the essentials
nnoremap <Space> <nop>
let mapleader="\<Space>"
nmap \ <leader>q
map <F2> :Startify <CR>
nmap <leader>r :so ~/.config/nvim/init.vim<CR>
nmap <leader>q :bd<CR>
nmap <leader>w :w<CR>
map <leader>s :Format<CR>
nnoremap <leader>t :filetype detect <CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
noremap <leader>e :PlugInstall<CR>

" Join lines keepin the cursor position
:nnoremap <silent> J :let p=getpos('.')<bar>join<bar>call setpos('.', p)<cr>

" new line in normal mode
nnoremap <expr> <Enter> &buftype ==# 'quickfix' ? "\<CR>" : 'o<ESC>'

" emulate windows copy, cut behavior
vnoremap <LeftRelease> "+y<LeftRelease>
vnoremap <C-c> "+y<CR>
vnoremap <C-x> "+d<CR>

" move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" horizontal navigation
nnoremap <S-h> g^
nnoremap <S-l> g$
vnoremap <S-h> g^
vnoremap <S-l> g$

" disable hl with 2 esc
noremap <silent><esc> <esc>:noh<CR><esc>

" trim white spaces
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" fugitive mappings
nmap <leader>gd :Gdiffsplit<CR>
nmap <leader>gb :Gblame<CR>

"" TERMINAL
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"                                      " map <ESC> for exiting terminal
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'    " simulate i<C-R>

" retain visual selection after `>` or `<`
vnoremap > >gv
vnoremap < <gv

" add new lines in NORMAL mode
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" formatting parenthesis for programming
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

" mapping C-S to save the file, in all the modes
nnoremap <silent><c-s> :<c-u>update<CR>
vnoremap <silent><c-s> <c-c>:update<CR>gv
inoremap <silent><c-s> <c-o>:update<CR><Esc>

" kill bad habits
" noremap h <nop>
" noremap j <nop>
" noremap k <nop>
" noremap l <nop>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" spell checker
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" overload q and w command
command! Q q
command! W w
command! Wq wq

