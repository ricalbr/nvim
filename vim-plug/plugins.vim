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
    " Plug 'vimwiki/vimwiki'                                  " wiki for notes and diary
    "}}}

    " ================= Functionalities ================= "{{{

    Plug 'neoclide/coc.nvim', {'branch': 'release'}         " LSP and more
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fzf itself
    Plug 'junegunn/fzf.vim'                                 " fuzzy search integration
    Plug 'SirVer/ultisnips'                                 " snippets manager
    Plug 'honza/vim-snippets'                               " actual snippets
    Plug 'sheerun/vim-polyglot'                             " improved syntax
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " better python
    Plug 'jiangmiao/auto-pairs'                             " autopairs utility
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
    Plug 'lervag/vimtex'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
