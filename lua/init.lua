-- init.lua
-- @ricalbr

-- fix path {{{
vim.opt.runtimepath: prepend('$XDG_CONFIG_HOME/nvim')
vim.opt.runtimepath: append('$XDG_DATA_HOME/nvim')
vim.opt.runtimepath: append('$XDG_CONFIG_HOME/nvim/after')

vim.cmd [[ let &packpath = &runtimepath ]]
vim.opt.packpath: append('$XDG_DATA_HOME/nvim/*')
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
-- vim.opt.diffopt: append{'foldcolumn:0', 'vertical'}
vim.g.splitvertical = true
vim.g.splitright = true
vim.g.splitbelow = true

-- folding options
vim.opt.foldlevelstart = 99
-- qui è un buon punto per partire https://github.com/wincent/wincent/commit/6c98fcb169345131e37e856d6ea2d264e61f3820
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldtext = 'user.foldtext()'

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
        Normal = {bg = 'none'},
        SignColumn = {bg = 'none'},
        GitSignsAdd = {fg = '#68d98a'},
        GitSignsChange = {fg = 'gold'},
        GitSignsDelete = {fg = 'love'},
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
telescope.setup{
  defaults = {
    path_display = { "smart" },
    mappings = {
        i = {
            ["?"] =require("telescope.actions.layout").toggle_preview, -- preview is disabled by default
        },
    },
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

-- key bindings
require('user.binds')
