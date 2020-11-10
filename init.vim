"
" INIT.VIM
"
" @rcrlbr
set nocp
filetype plugin on
filetype indent on
syntax enable

set termguicolors                                       " Opaque Background
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"                  " Accurate colors for alacritty
let &t_8b = "\<Esc>[48:2;%lu;%lu;%lum"
set shell=/usr/bin/zsh
set mouse-=a                                            " disable mouse scrolling
set clipboard+=unnamedplus                              " use system clipboard by default
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent     " tab width
set smartindent                                         " C-like indenting
set expandtab smarttab                                  " tab key actions
set incsearch ignorecase smartcase hlsearch             " highlight text while searching
set list listchars=trail:»,tab:»-                       " use tab to navigate in list mode
set fillchars+=vert:\▏                                  " requires a patched nerd font
" set wrap break indent                                    " wrap long lines to the width set by two
set encoding=utf-8                                      " text encoding
set number relativenumber                               " enable relative numbers on the left
set title                                               " tab title as file name
set noshowmode                                          " don't show current mode below statusline
set noshowcmd                                           " to get rid of display of last command
set conceallevel=2                                      " set this so we wont break indentation plugin
set splitright                                          " open vertical split to the right
set splitbelow                                          " open horizontal split to the bottom
set tw=90                                               " auto wrap lines that are longer than that
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
" set nocursorline
" set nocursorcolumn
set scrolljump=5
set scrolloff=5
set sidescrolloff=5
set lazyredraw
set redrawtime=10000
set synmaxcol=180
set re=1
setlocal spell
set spelllang=it,en_gb
set noswapfile

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
"" built in plugins
let loaded_netrw = 0                                    " diable netrw
let g:omni_sql_no_default_maps = 1                      " disable sql omni completion
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = expand('/usr/bin/python3')


"   FUNCTIONS, AUTOCMDs AND MAPPINGS"
source $HOME/.config/nvim/functions/functions.vim
source $HOME/.config/nvim/mappings/mappings.vim


"   VIM-PLUG AND PLUGINS
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Looks and GUI stuff
    Plug 'vim-airline/vim-airline'                          " airline status bar
    Plug 'ryanoasis/vim-devicons'                           " pretty icons everywhere

    " Functionalities
    Plug 'neoclide/coc.nvim', {'branch': 'release'}         " LSP and more
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fzf itself
    Plug 'junegunn/fzf.vim'                                 " fuzzy search integration
    Plug 'SirVer/ultisnips'                                 " snippets manager
    Plug 'honza/vim-snippets'                               " actual snippets
    Plug 'tpope/vim-commentary'                             " better commenting
    Plug 'tpope/vim-fugitive'                               " git support
    Plug 'tpope/vim-surround'                               " surround stuff
    Plug 'mhinz/vim-startify'                               " cool start up screen
    Plug 'psliwka/vim-smoothie'                             " smooth scrolling
    Plug 'wellle/tmux-complete.vim'                         " complete words from a tmux panes
    Plug 'christoomey/vim-tmux-navigator'                   " seamless vim and tmux navigation

    " C/C++
    Plug 'bfrg/vim-cpp-modern', {'for': 'cpp'}              " enhanced C/C++ syntax

    " Python
    Plug 'vim-python/python-syntax', {'for': 'python'}      " enhanced Python syntax

    " Markdown
    Plug 'iamcco/markdown-preview.nvim', {
        \'do': 'cd app && yarn install',
        \'for': 'markdown'}                                 " Markdown live preview

    " LaTeX
    Plug 'lervag/vimtex', {'for': 'tex'}                    " LaTeX extension for VIM

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

"   THEMING
colorscheme soft                                          " light colorscheme
colorscheme dark                                          " dark colorshceme
let g:airline_theme='transparent'

hi Pmenu guibg='#00010a' guifg=white                      " popup menu colors
hi Comment gui=italic cterm=italic                        " italic comments
hi Search guibg=#b16286 guifg=#ebdbb2 gui=NONE            " search string highlight color
hi NonText guifg=bg                                       " mask ~ on empty lines
hi clear CursorLineNr                                     " use the theme color for relative number
hi CursorLineNr gui=bold                                  " make relative number bold
hi SpellBad guifg=NONE gui=undercurl                      " misspelled words in GUI
hi SpellBad cterm=undercurl,bold                          " misspelled words in terminal

" coc multi cursor highlight color
hi CocCursorRange guibg=#b16286 guifg=#ebdbb2
let g:python_highlight_all = 1

"   PLUGINS AND FUNCTIONALITIES
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/markdown-preview.vim
source $HOME/.config/nvim/plug-config/start-screen.vim
source $HOME/.config/nvim/plug-config/tmux-navigator.vim
source $HOME/.config/nvim/plug-config/ultisnips.vim
source $HOME/.config/nvim/plug-config/vim-commentary.vim
source $HOME/.config/nvim/plug-config/vim-conda.vim
source $HOME/.config/nvim/plug-config/vim-surround.vim
source $HOME/.config/nvim/plug-config/vimtex.vim
