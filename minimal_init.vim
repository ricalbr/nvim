filetype plugin indent on
syntax on
set backspace=indent,eol,start
set hidden
set noswapfile

set shell=/usr/bin/bash
set rnu
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent
set smartindent
set expandtab smarttab
set incsearch ignorecase smartcase hlsearch
set splitright
set splitbelow
set undofile
set undodir=/tmp

set path+=.,**
set scrolljump=5
set scrolloff=5
set sidescrolloff=5
set lazyredraw
set redrawtime=10000
set synmaxcol=0

" spelling
setlocal spell
set spellfile=~/.config/nvim/spell/en.utf-8.add
set spelllang=it,en_gb

" File Explorer
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction


" MAPPINGS
nnoremap <Space> <nop>
let mapleader="\<Space>"
nmap \ <leader>q
nmap <leader>r :so ~/.config/nvim/minimal_init.vim<CR>
nmap <leader>q :bd<CR>
nmap <leader>w :w<CR>
nnoremap <leader>t :filetype detect <CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
noremap <leader>n :call ToggleNetrw()<CR>

" Join lines keepin the cursor position
:nnoremap <silent> J :let p=getpos('.')<bar>join<bar>call setpos('.', p)<cr>

" retain visual selection after `>` or `<`
vnoremap > >gv
vnoremap < <gv

" emulate windows copy, cut behavior
vnoremap <LeftRelease> "+y<LeftRelease>
vnoremap <C-c> "+y<CR>
vnoremap <C-x> "+d<CR>

" move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" switch between splits using ctrl + {h,j,k,l}
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l

tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" horizontal navigation
nnoremap <S-h> g^
nnoremap <S-l> g$
vnoremap <S-h> g^
vnoremap <S-l> g$

" disable hl with 2 esc
noremap <silent><esc> <esc>:noh<CR><esc>

" trim white spaces
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" add new lines in NORMAL mode
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" formatting parenthesis for programming
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

" mapping C-S to save the file, in all the modes
nnoremap <silent><C-s> :<c-u>update<CR>
vnoremap <silent><C-s> <c-c>:update<CR>gv
inoremap <silent><C-s> <c-o>:update<CR><Esc>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" overload q and w command
command! Q q
command! W w
command! Wq wq
