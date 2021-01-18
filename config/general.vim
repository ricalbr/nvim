" VIM GENERAL SETTINGS
set nocp
filetype plugin on
filetype indent on
syntax enable

set shell=/usr/bin/bash
set mouse-=a                                            " disable mouse scrolling
set clipboard+=unnamedplus                              " use system clipboard by default
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent     " tab width
set smartindent                                         " C-like indenting
set expandtab smarttab                                  " tab key actions
set incsearch ignorecase smartcase hlsearch             " highlight text while searching
set list listchars=trail:·,tab:•-                       " use tab to navigate in list mode
set fillchars+=vert:\▏                                  " requires a patched nerd font
set wrap breakindent                                    " wrap long lines to the width set by tw
set encoding=utf-8                                      " text encoding
set number relativenumber                               " enable relative numbers on the left
set title                                               " tab title as file name
set noshowmode                                          " don't show current mode below statusline
set noshowcmd                                           " to get rid of display of last command
set conceallevel=2                                      " set this so we wont break indentation plugin
set splitright                                          " open vertical split to the right
set splitbelow                                          " open horizontal split to the bottom
set tw=80                                               " auto wrap lines that are longer than that
set history=1000                                        " history limit
set backspace=indent,eol,start                          " sensible backspacing
set undofile                                            " enable persistent undo
set undodir=/tmp                                        " undo temp file directory
set foldlevel=0                                         " open all folds by default
set inccommand=nosplit                                  " visual feedback while substituting
set showtabline=2                                       " always show tabline
set grepprg=rg\ --vimgrep                               " use rg as default grepper

" performance tweaks
set path+=.,**
set nocursorline
set nocursorcolumn
set scrolljump=5
set scrolloff=5
set sidescrolloff=5
set lazyredraw
set redrawtime=10000
set synmaxcol=0
set re=1
set noswapfile

" spelling
setlocal spell
set spelllang=it,en_gb

" required by coc
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes
set pumheight=12                                        " number of suggestions in menu

"   PLUGINS CONFIGURATION"
let loaded_netrw = 0                                    " disable netrw in neovim (use coc-explorer)
let g:omni_sql_no_default_maps = 1                      " disable sql omni completion
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
" let g:python3_host_prog = expand('/usr/bin/python3')
let g:python3_host_prog = '/home/$USER/miniconda3/bin/python3'

