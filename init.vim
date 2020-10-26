"
" INIT.VIM
"
" rcrlbr

set termguicolors                                       " Opaque Background
set mouse=a                                             " enable mouse scrolling
set clipboard+=unnamedplus                              " use system clipboard by default
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent     " tab width
set smartindent         " C-like indenting
set expandtab smarttab                                  " tab key actions
set incsearch ignorecase smartcase hlsearch             " highlight text while searching
set list listchars=trail:»,tab:»-                       " use tab to navigate in list mode
set fillchars+=vert:\▏                                  " requires a patched nerd font (try FiraCode)
set wrap breakindent                                    " wrap long lines to the width set by tw
set encoding=utf-8                                      " text encoding
set number                                              " enable numbers on the left
set relativenumber                                      " current line is 0
set title                                               " tab title as file name
set noshowmode                                          " dont show current mode below statusline
set noshowcmd                                           " to get rid of display of last command
set conceallevel=2                                      " set this so we wont break indentation plugin
set splitright                                          " open vertical split to the right
set splitbelow                                          " open horizontal split to the bottom
set tw=90                                               " auto wrap lines that are longer than that
set emoji                                               " enable emojis
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
set lazyredraw
set redrawtime=10000
set synmaxcol=180
set re=1
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


"   PLUGINS CONFIGURATION"
"" built in plugins
let loaded_netrw = 0                                    " diable netrw
let g:omni_sql_no_default_maps = 1                      " disable sql omni completion
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = expand('/usr/bin/python3')
let g:python_host_prog = '/usr/bin/python'              " Python2 PATH


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

    " ================= looks and GUI stuff ================== "{{{

    Plug 'vim-airline/vim-airline'                          " airline status bar
    Plug 'vim-airline/vim-airline-themes'                   " airline themes
    Plug 'ryanoasis/vim-devicons'                           " pretty icons everywhere
    Plug 'rafi/awesome-vim-colorschemes'                    " vim-colorschemes collection
    Plug 'vimwiki/vimwiki'                                  " wiki for notes and diary
    "}}}

    " ================= Functionalities ================= "{{{

    Plug 'neoclide/coc.nvim', {'branch': 'release'}         " LSP and more
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fzf itself
    Plug 'junegunn/fzf.vim'                                 " fuzzy search integration
    Plug 'SirVer/ultisnips'                                 " snippets manager
    Plug 'honza/vim-snippets'                               " actual snippets
    Plug 'sheerun/vim-polyglot'                             " improved syntax
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " better python
    Plug 'jiangmiao/auto-pairs'                             " auto-pairs utility
    Plug 'tpope/vim-commentary'                             " better commenting
    Plug 'tpope/vim-fugitive'                               " git support
    Plug 'tpope/vim-eunuch'                                 " run common Unix commands inside Vim
    Plug 'tpope/vim-surround'
    Plug 'mhinz/vim-startify'                               " cool start up screen
    Plug 'psliwka/vim-smoothie'                             " some very smooth ass scrolling
    Plug 'wellle/tmux-complete.vim'                         " complete words from a tmux panes
    Plug 'christoomey/vim-tmux-navigator'                   " seamless vim and tmux navigation

    " Markdown
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

    " LaTeX
    " Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    Plug 'lervag/vimtex'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif


"   THEMING
set background=light
colorscheme solarized8_high                               " light colorscheme
colorscheme nord                                          " dark colorscheme
source $HOME/.config/nvim/themes/airline.vim

hi Pmenu guibg='#00010a' guifg=white                      " popup menu colors
hi Comment gui=italic cterm=italic                        " italic comments
hi Search guibg=#b16286 guifg=#ebdbb2 gui=NONE            " search string highlight color
hi NonText guifg=bg                                       " mask ~ on empty lines
hi clear CursorLineNr                                     " use the theme color for relative number
hi CursorLineNr gui=bold                                  " make relative number bold
hi SpellBad guifg=NONE gui=bold,undercurl                 " misspelled words

" colors for git (especially the gutter)
hi DiffAdd  guibg=#0f111a guifg=#43a047
hi DiffChange guibg=#0f111a guifg=#fdd835
hi DiffRemoved guibg=#0f111a guifg=#e53935

" coc multi cursor highlight color
hi CocCursorRange guibg=#b16286 guifg=#ebdbb2


"   PLUGINS AND FUNCTIONALITIES
source $HOME/.config/nvim/plug-config/autopairs.vim
" source $HOME/.config/nvim/plug-config/deoplete.vim
" source $HOME/.config/nvim/plug-config/floaterm.vim
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/vimtex.vim
" source $HOME/.config/nvim/plug-config/templates.vim
" source $HOME/.config/nvim/plug-config/vbox.vim
source $HOME/.config/nvim/plug-config/start-screen.vim
source $HOME/.config/nvim/plug-config/markdown-preview.vim
" source $HOME/.config/nvim/plug-config/nerdtree.vim
" source $HOME/.config/nvim/plug-config/pandoc.vim
" source $HOME/.config/nvim/plug-config/sneak.vim
" source $HOME/.config/nvim/plug-config/quickscope.vim
source $HOME/.config/nvim/plug-config/semshi.vim
source $HOME/.config/nvim/plug-config/tmux-navigator.vim
source $HOME/.config/nvim/plug-config/ultisnips.vim
source $HOME/.config/nvim/plug-config/vim-commentary.vim
source $HOME/.config/nvim/plug-config/vim-surround.vim
