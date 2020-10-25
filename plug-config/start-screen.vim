let g:startify_lists = [
    \ { 'type': 'dir',      'header': ['   Current Directory '. getcwd()] },
    \ { 'type': 'files',    'header': ['   Files']                        },
    \ { 'type': 'sessions', 'header': ['   Sessions']                     },
    \ { 'type': 'bookmarks','header': ['   Bookmarks']                    },
    \ { 'type': 'commands', 'header': ['   Commands']                     },
    \ ]

let g:startify_padding_left = 10
let g:startify_session_persistence = 1
let g:startify_enable_special = 0
let g:startify_change_to_vcs_root = 1

let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_fortune_use_unicode = 1
let g:webdevicons_enable_startify = 1

function! StartifyEntryFormat()
        return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
    endfunction

" bookmark examples
let  g:startify_bookmarks =  [
    \ {'v': '~/.config/nvim'},
    \ {'d': '~/.dotfiles' },
    \ {'g': '~/git'},
    \ ]

" custom commands
let g:startify_commands = [
    \ {'ch':  ['Health Check', ':checkhealth']},
    \ {'ps': ['Plugins status', ':PlugStatus']},
    \ {'pc': ['Plugins clean', ':PlugClean']},
    \ {'pu': ['Update vim plugins',':PlugUpdate | PlugUpgrade']},
    \ {'uc': ['Update coc Plugins', ':CocUpdate']},
    \ {'h':  ['Help', ':help']},
    \ {'z':  ['zsh', '~/.zshrc'] },
    \ ]

let g:startify_enable_special = 0