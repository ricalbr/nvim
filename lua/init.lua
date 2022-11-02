-- init.lua
-- @ricalbr

-- fix path {{{
vim.opt.runtimepath:prepend('$XDG_CONFIG_HOME/nvim')
vim.opt.runtimepath:append('$XDG_DATA_HOME/nvim')
vim.opt.runtimepath:append('$XDG_CONFIG_HOME/nvim/after')

vim.cmd [[ let &packpath = &runtimepath ]]
vim.opt.packpath:append('$XDG_DATA_HOME/nvim/*')
-- }}}

require('user.plugins')
require('impatient') -- improve plugin performances

-- basic options {{{

-- disable netrw, use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.cindent = true
vim.opt.cinoptions = ':.5s,>1s,p0,t0,(0,g2'
vim.opt.cinwords = 'if,else,while,do,for,switch,case,class,try'

vim.opt.path = '.,**'
vim.opt.undofile = true
vim.g.noswapfile = true

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.signcolumn = 'yes'
vim.opt.scrolljump = 5
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 5
vim.g.noshowmode = true
vim.opt.lazyredraw = true
vim.opt.redrawtime = 100
vim.opt.synmaxcol = 0

-- listchars options
vim.opt.list = true
vim.opt.listchars = {
    nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    extends = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    tab = '▷⋯', -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
    trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}

-- fillchar options
vim.opt.fillchars = {
    diff = '∙', -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    eob = ' ', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
    fold = '·', -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    vert = '┃', -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}

vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.diffopt:append { 'foldcolumn:0', 'vertical' }
vim.g.splitvertical = true
vim.g.splitright = true
vim.g.splitbelow = true

-- folding options
vim.opt.foldlevelstart = 99
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- pretty-fold setup{{{
require('pretty-fold').setup({
    sections = {
        left = { 'content', },
        right = { ' ', 'number_of_folded_lines', ' ',
            function(config) return config.fill_char:rep(3) end
        }
    },
    fill_char = '·',
    remove_fold_markers = true,
    keep_indentation = true,
    process_comment_signs = 'spaces',
    comment_signs = {},
    stop_words = {
        '@brief%s*', -- (for C++) Remove '@brief' and all spaces after.
    },
    add_close_pattern = true, -- true, 'last_line' or false
    matchup_patterns = {
        { '{', '}' },
        { '%(', ')' }, -- % to escape lua pattern char
        { '%[', ']' }, -- % to escape lua pattern char
    },
    ft_ignore = { 'neorg' },
}) -- }}}

vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignore:append { '*.bak', '*.swp', '*.swo', '*.a', '*.o', '*.so', '*.pyc', '*.class', '*.jpg', '*.jpeg',
    '*.gif', '*.png', '*.pdf', '*/.git*', '*.tar', '*.zip', '*.obj', '*.exe', '*.py[co]', '.svn' }
vim.opt.completeopt = 'longest,menuone'
vim.opt.omnifunc = 'syntaxcomplete#Complete'
-- }}}

-- autocommands {{{
vim.cmd [[
augroup Operations
  autocmd!
  autocmd BufReadPost * call autocmdfunctions#LastPosition()
  autocmd BufWritePre * call autocmdfunctions#RmvTrailingSpaces()
augroup END
]]
-- }}}

-- colorscheme {{{
vim.opt.termguicolors = true
require('rose-pine').setup({
    dark_variant = 'moon',
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = false,
    disable_float_background = false,
    disable_italics = false,

    highlight_groups = {
        ColorColumn = { bg = 'rose' },
        Normal = { bg = 'none' },
        SignColumn = { bg = 'none' },
        GitSignsAdd = { fg = '#68d98a' },
        GitSignsChange = { fg = 'gold' },
        GitSignsDelete = { fg = 'love' },
    }
})
vim.cmd [[colorscheme rose-pine]]

require('lualine').setup {
    options = {
        theme = 'rose-pine',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
    }
}
-- }}}

-- treesitter {{{
local configs = require("nvim-treesitter.configs")
configs.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
}
-- }}}

-- telescope {{{
local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    return
end

telescope.load_extension('frecency')
telescope.setup {
    defaults = {
        path_display = { "smart" },
        mappings = {
            i = {
                ["?"] = require("telescope.actions.layout").toggle_preview, -- preview is disabled by default
            },
        },
    },
    extensions = {
        conda = { home = "$HOME/miniconda3/" }
    },
}
-- }}}

-- completion and lsp {{{
local saga = require 'lspsaga'
saga.init_lsp_saga({
    max_preview_lines = 15,
    code_action_icon = "",
})

require('user.cmp')
require('user.lsp')
-- }}}

-- other plugins {{{
require('Comment').setup()
require('user.nvimtree')
require('user.gitsigns')
-- }}}

-- key bindings {{{
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local function map(m, k, v, o)
    vim.keymap.set(m, k, v, o)
end

-- overload q and w command
vim.api.nvim_command('command! Q q')
vim.api.nvim_command('command! W w')
vim.api.nvim_command('command! Wq wq')

-- write file with sudo
vim.cmd.cnoreabbrev({ 'w!!', 'w !sudo tee > /dev/null %<CR>' })

-- set leader key
vim.g.mapleader = ' '

-- juggling with files w/ telescope
vim.keymap.set('n', '<leader>ff',
    ':lua require"telescope.builtin".find_files(require("telescope.themes").get_dropdown({ previewer = false }))<CR>',
    opts)
vim.keymap.set('n', '<leader>fg',
    ':lua require"telescope.builtin".live_grep(require("telescope.themes").get_dropdown({ previewer = false }))<CR>',
    opts)
vim.keymap.set('n', '<leader>fb',
    ':lua require"telescope.builtin".buffers(require("telescope.themes").get_dropdown({ previewer = false }))<CR>', opts)
vim.keymap.set('n', '<leader>fh',
    ':lua require"telescope.builtin".help_tags(require("telescope.themes").get_dropdown({ previewer = false }))<CR>',
    opts)

map('n', '\\', ':bd<CR>', opts)
map('n', '<leader>nt', ':tabnew<CR>', opts)
map('n', '<leader>dt', ':tabclose<CR>', opts)
map('n', '<Tab>', ':bnext<CR>', opts)
map('n', '<S-Tab>', ':bprevious<CR>', opts)
map('n', '<Leader>d', ':w !diff % -<CR>', opts)
map('n', '<Leader>re', ':retab<CR>', opts)

-- mapping C-s to save the file, in all the modes
map('n', '<C-s>', '<Esc>:Update<CR>', opts)
map('v', '<C-s>', '<Esc>:Update<CR>gv', opts)
map('i', '<C-s>', '<Esc>:Update<CR>', opts)

-- join lines keepin the cursor position
map('n', 'J', ':let p=getpos(".")<bar>join<bar>call setpos(".", p)<CR>', opts)

-- move vertically by visual line (don't skip wrapped lines)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)

-- retain visual selection after `>` or `<`
map('v', '>', '>gv', opts)
map('v', '<', '<gv', opts)

-- argslist navigation
map('n', '[a', ':previous<CR>', opts)
map('n', ']a', ':next<CR>', opts)
map('n', '[A', ':first<CR>', opts)
map('n', ']A', ':last<CR>', opts)

-- quickfix list navigation
map('n', '[q', ':cp<CR>', opts)
map('n', ']q', ':cn<CR>', opts)

-- switch between splits using ctrl + {h,j,k,l}
map('i', '<C-h>', '<C-\\><C-N><C-w>h', opts)
map('i', '<C-j>', '<C-\\><C-N><C-w>j', opts)
map('i', '<C-k>', '<C-\\><C-N><C-w>k', opts)
map('i', '<C-l>', '<C-\\><C-N><C-w>l', opts)

map('n', '<C-h>', '<C-\\><C-N><C-w>h', opts)
map('n', '<C-j>', '<C-\\><C-N><C-w>j', opts)
map('n', '<C-k>', '<C-\\><C-N><C-w>k', opts)
map('n', '<C-l>', '<C-\\><C-N><C-w>l', opts)

map('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
map('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
map('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
map('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- window management
map('n', '<Leader>0', '<C-w>=', opts)
map('n', '<Leader>+', ':vertical resize +10<CR>', opts)
map('n', '<Leader>-', ':vertical resize -10<CR>', opts)

-- no K or arrow keys
map('n', '<K>', '<NOP>', opts)
map('n', '<Down>', '<NOP>', opts)
map('n', '<Up>', '<NOP>', opts)
map('n', '<Left>', '<NOP>', opts)
map('i', '<Right>', '<NOP>', opts)
map('i', '<Down>', '<NOP>', opts)
map('i', '<Up>', '<NOP>', opts)
map('i', '<Left>', '<NOP>', opts)
map('i', '<Right>', '<NOP>', opts)

-- gitsigns
local _, gitsigns = pcall(require, "gitsigns")
gitsigns.setup {
    on_attach = function()
        map('n', '<Leader>sh', ':Gitsigns stage_hunk<CR>', opts)
        map('n', '<Leader>rh', ':Gitsigns reset_hunk<CR>', opts)
        map('n', '<Leader>nh', ':Gitsigns next_hunk<CR>', opts)
        map('n', '<Leader>ph', ':Gitsigns prev_hunk<CR>', opts)
        map('n', '<Leader>pvh', ':Gitsigns preview_hunk<CR>', opts)
    end
}

-- telescope
vim.api.nvim_command('command Conda :lua require"telescope".extensions.conda.conda(require("telescope.themes").get_cursor())')

-- nvim-tree
map('n', '<Leader>nn', ':NvimTreeToggle<CR>')
-- }}}
