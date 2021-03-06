"
" INIT.VIM
"
" @ricalbr

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
    Plug 'ricalbr/vim-colors'                               " colorschemes

    " Functionalities
    Plug 'neoclide/coc.nvim', {'branch': 'release'}         " LSP and more
    Plug 'antoinemadec/FixCursorHold.nvim'                  " fix CusorHold performances
    Plug 'liuchengxu/vista.vim'                             " tagbar w/ctags
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fzf itself
    Plug 'junegunn/fzf.vim'                                 " fuzzy search integration
    Plug 'SirVer/ultisnips'                                 " snippets manager
    Plug 'honza/vim-snippets'                               " actual snippets
    Plug 'tpope/vim-commentary'                             " better commenting
    Plug 'tpope/vim-fugitive'                               " git support
    Plug 'tpope/vim-surround'                               " surround stuff
    Plug 'rhysd/clever-f.vim'                               " navigate just with f/F/t/T
    Plug 'mhinz/vim-startify'                               " cool start up screen
    Plug 'psliwka/vim-smoothie'                             " smooth scrolling
    Plug 'christoomey/vim-tmux-navigator'                   " seamless vim and tmux navigation

    " C/C++
    Plug 'bfrg/vim-cpp-modern', {'for': 'cpp'}              " enhanced C/C++ syntax
    Plug 'xavierd/clang_complete', {'for': 'cpp'}           " enhanced C/C++ syntax

    " Python
    Plug 'vim-python/python-syntax', {'for': 'python'}      " enhanced Python syntax

    " Markdown
    Plug 'reedes/vim-pencil'                                " prose utility
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
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" colorscheme soft                                          " light colorscheme
colorscheme dark                                          " dark colorshceme
let g:airline_theme='transparent'

autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE      " transparent background
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
let g:cursorhold_updatetime = 100

"   FUNCTIONS, AUTOCMDs AND MAPPINGS"
source $HOME/.config/nvim/config/general.vim
source $HOME/.config/nvim/functions/functions.vim
source $HOME/.config/nvim/config/mappings/mappings.vim

"   PLUGINS AND FUNCTIONALITIES
source $HOME/.config/nvim/config/cleverf.vim
source $HOME/.config/nvim/config/coc.vim
source $HOME/.config/nvim/config/fzf.vim
source $HOME/.config/nvim/config/markdown-preview.vim
source $HOME/.config/nvim/config/start-screen.vim
source $HOME/.config/nvim/config/tmux-navigator.vim
source $HOME/.config/nvim/config/ultisnips.vim
source $HOME/.config/nvim/config/vim-pencil.vim
source $HOME/.config/nvim/config/vim-surround.vim
source $HOME/.config/nvim/config/vimtex.vim
source $HOME/.config/nvim/config/vista.vim
