-- init.lua
-- @ricalbr

-- set <space> as the leader key
--  NOTE: must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- install`lazy.nvim` plugin manager from https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

        'lewis6991/impatient.nvim', -- optimize packer with caching
        'rose-pine/neovim',         -- colorscheme
        { "catppuccin/nvim",        name = "catppuccin", priority = 1000 },
        'tpope/vim-fugitive',
        'tpope/vim-repeat',
        'anuvyklack/pretty-fold.nvim',
        'nvim-lualine/lualine.nvim',
        { 'numToStr/Comment.nvim',  opts = {} },
        { 'kylechui/nvim-surround', opts = {} },
        { 'stevearc/oil.nvim',      opts = {}, },
        { 'folke/which-key.nvim',   opts = {} },
        {
            "nathom/filetype.nvim",
            config = function()
                require("filetype").setup({
                    overrides = { extensions = { pgm = "gcode", gcode = "gcode", g = "gcode", ngc = "gcode", } },
                })
            end,
        },

        {
            'neovim/nvim-lspconfig',       -- LSP Configuration & Plugins
            dependencies = {
                'williamboman/mason.nvim', -- automatically install lsps to stdpath for neovim
                'williamboman/mason-lspconfig.nvim',
                'WhoIsSethDaniel/mason-tool-installer.nvim',
                'glepnir/lspsaga.nvim',
                { 'j-hui/fidget.nvim', opts = {} },
                'folke/neodev.nvim', -- additional lua configuration, makes nvim stuff amazing!
            },
        },

        {
            'hrsh7th/nvim-cmp',         -- autocompletion
            dependencies = {
                'l3mon4d3/luasnip',     -- snippet engine & its associated nvim-cmp source
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-nvim-lsp', -- adds lsp completion capabilities
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'hrsh7th/cmp-nvim-lua',
                'rafamadriz/friendly-snippets', -- adds a number of user-friendly snippets
                'L3MON4D3/LuaSnip',
            },
        },

        {
            -- adds git related signs to the gutter, as well as utilities for managing changes
            'lewis6991/gitsigns.nvim',
            config = function()
                require("config/gitsigns")
            end,
        },

        {
            'lukas-reineke/indent-blankline.nvim', -- add indentation guides even on blank lines
            main = 'ibl',                          -- see `:help ibl`
            opts = {},
        },

        {
            "nvim-neorg/neorg",
            build = ":Neorg sync-parsers",
            -- tag = "*",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                require("neorg").setup {
                    load = {
                        ["core.defaults"] = {},  -- Loads default behaviour
                        ["core.concealer"] = {}, -- Adds pretty icons to your documents
                        ["core.dirman"] = {      -- Manages Neorg workspaces
                            config = {
                                workspaces = {
                                    notes = "~/notes",
                                },
                            },
                        },
                    },
                }
            end,
            run = ":Neorg sync-parsers",
        },

        {
            "folke/zen-mode.nvim",
            opts = {}
        },

        -- fuzzy finder (files, lsp, etc)
        {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            dependencies = {
                'nvim-lua/plenary.nvim',
                -- fuzzy finder algorithm which requires local dependencies to be built.
                -- only load if `make` is available. make sure you have the system requirements installed.
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    build = 'make',
                    cond = function()
                        return vim.fn.executable 'make' == 1
                    end,
                },
            },
            config = require("config/telescope"),
        },

        {
            -- highlight, edit, and navigate code
            'nvim-treesitter/nvim-treesitter',
            dependencies = {
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            build = ':TSUpdate',
        },

        {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({
                    enable_check_bracket_line = false, -- don't add pairs if it already has a close pair in the same line
                    ignored_next_char = "[%w%.]",      -- will ignore alphanumeric and `.` symbol
                    check_ts = true,                   -- use treesitter to check for a pair.
                })
            end,
        },
        require 'plugins.autoformat',
    },
    {})

require("impatient") -- improve plugin performances

-- avoid loading unwanted plugins in vim/vimfiles
vim.cmd("set rtp-=/usr/share/vim/vimfiles")

-- don't load built-in plugins
local builtins = {
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "matchit",
    "matchparen",
    "logiPat",
    "rrhelper",
    -- "netrw",
    -- "netrwPlugin",
    -- "netrwSettings",
    -- "netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
    vim.g["loaded_" .. plugin] = 1
end

-- netrw options
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
-- }}}

-- basic options {{{
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.clipboard = "unnamedplus"
vim.opt.cindent = true
vim.opt.cinoptions = ":.5s,>1s,p0,t0,(0,g2"
vim.opt.cinwords = "if,else,while,do,for,switch,case,class,try"

vim.opt.path = ".,**"
vim.opt.undofile = true
vim.g.noswapfile = true

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.signcolumn = "yes"
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
    nbsp = "·",
    extends = "›",
    precedes = "‹",
    tab = "  ",
    trail = "·",
}

-- fillchar options
vim.opt.fillchars = {
    diff = "∙",
    eob = " ",
    fold = "·",
    vert = "┃",
}

vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.diffopt:append({ "foldcolumn:0", "vertical" })
vim.g.splitvertical = true
vim.g.splitright = true
vim.g.splitbelow = true

-- folding options
vim.opt.foldlevelstart = 99
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- pretty-fold setup{{{
require("pretty-fold").setup({
    sections = {
        left = { "content" },
        right = {
            " ",
            "number_of_folded_lines",
            " ",
            function(config)
                return config.fill_char:rep(3)
            end,
        },
    },
    fill_char = "·",
    remove_fold_markers = true,
    keep_indentation = true,
    process_comment_signs = "spaces",
    comment_signs = {},
    stop_words = {
        "@brief%s*",          -- (for C++) Remove '@brief' and all spaces after.
    },
    add_close_pattern = true, -- true, 'last_line' or false
    matchup_patterns = {
        { "{",  "}" },
        { "%(", ")" }, -- % to escape lua pattern char
        { "%[", "]" }, -- % to escape lua pattern char
    },
    ft_ignore = { "neorg" },
}) -- }}}

vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({
    "*.bak",
    "*.swp",
    "*.swo",
    "*.a",
    "*.o",
    "*.so",
    "*.pyc",
    "*.class",
    "*.jpg",
    "*.jpeg",
    "*.gif",
    "*.png",
    "*.pdf",
    "*/.git*",
    "*.tar",
    "*.zip",
    "*.obj",
    "*.exe",
    "*.py[co]",
    ".svn",
})
vim.opt.completeopt = "longest,menuone"
vim.opt.omnifunc = "syntaxcomplete#Complete"
-- }}}

-- colorscheme {{{
vim.opt.termguicolors = true
require("rose-pine").setup({
    dark_variant = "moon",
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    styles = {
        bold = true,
        italic = true,
        transparency = true,
    },

    highlight_groups = {
        ColorColumn = { bg = "rose" },
        Normal = { bg = "none" },
        SignColumn = { bg = "none" },
        GitSignsAdd = { fg = "#68d98a" },
        GitSignsChange = { fg = "gold" },
        GitSignsDelete = { fg = "love" },
    },
})
vim.cmd("colorscheme rose-pine")

require("lualine").setup({
    options = {
        theme = "rose-pine",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        globalstatus = true,
    },
    sections = {
        lualine_b = { "filename" },
        lualine_c = { "" },
        lualine_y = { "branch", "diff", "diagnostics" },
    },
    inactive_sections = {
        lualine_b = { "filename" },
        lualine_c = { "" },
    },
})
-- }}}

-- key bindings {{{
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local function map(m, k, v, o)
    vim.keymap.set(m, k, v, o)
end

-- overload q and w command
vim.api.nvim_command("command! Q q")
vim.api.nvim_command("command! W w")
vim.api.nvim_command("command! Wq wq")

-- write file with sudo
vim.cmd.cnoreabbrev({ "w!!", "w !sudo tee > /dev/null %<CR>" })

-- set leader key
vim.g.mapleader = " "

-- keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

map("n", "\\", ":bd<CR>", opts)
map("n", "<leader>nt", ":tabnew<CR>", opts)
map("n", "<leader>dt", ":tabclose<CR>", opts)
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)
map("n", "<Leader>re", ":retab<CR>", opts)

-- mapping C-s to save the file, in all the modes
map("n", "<C-s>", "<Esc>:Update<CR>", opts)
map("v", "<C-s>", "<Esc>:Update<CR>gv", opts)
map("i", "<C-s>", "<Esc>:Update<CR>", opts)

-- join lines keepin the cursor position
map("n", "J", ':let p=getpos(".")<bar>join<bar>call setpos(".", p)<CR>', opts)

-- move vertically by visual line (don't skip wrapped lines)
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- retain visual selection after `>` or `<`
map("v", ">", ">gv", opts)
map("v", "<", "<gv", opts)

-- argslist navigation
map("n", "[a", ":previous<CR>", opts)
map("n", "]a", ":next<CR>", opts)
map("n", "[A", ":first<CR>", opts)
map("n", "]A", ":last<CR>", opts)

-- quickfix list navigation
map("n", "[q", ":cp<CR>", opts)
map("n", "]q", ":cn<CR>", opts)

-- switch between splits using ctrl + {h,j,k,l}
map("i", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("i", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("i", "<C-k>", "<C-\\><C-N><C-w>k", opts)
map("i", "<C-l>", "<C-\\><C-N><C-w>l", opts)

map("n", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("n", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("n", "<C-k>", "<C-\\><C-N><C-w>k", opts)
map("n", "<C-l>", "<C-\\><C-N><C-w>l", opts)

map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- window management
map("n", "<Leader>0", "<C-w>=", opts)
map("n", "<Leader>+", ":vertical resize +10<CR>", opts)
map("n", "<Leader>-", ":vertical resize -10<CR>", opts)

-- no K or arrow keys
map("n", "<K>", "<NOP>", opts)
map("n", "<Down>", "<NOP>", opts)
map("n", "<Up>", "<NOP>", opts)
map("n", "<Left>", "<NOP>", opts)
map("i", "<Right>", "<NOP>", opts)
map("i", "<Down>", "<NOP>", opts)
map("i", "<Up>", "<NOP>", opts)
map("i", "<Left>", "<NOP>", opts)
map("i", "<Right>", "<NOP>", opts)

-- nvim-tree
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- }}}

-- autocommands {{{
local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    command = [[:%s/\s\+$//e]],
    group = TrimWhiteSpaceGrp,
})

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd(
    "BufReadPost",
    { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- enable spell checking for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.txt", "*.md", "*.tex" },
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = "en,it"
    end,
})
-- }}}

-- treesitter {{{
-- defer treesitter setup after first render to improve startup time
vim.defer_fn(function()
    require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = false,
        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- List of parsers to ignore installing
        ignore_install = {},
        -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
        modules = {},
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<c-space>',
                node_incremental = '<c-space>',
                scope_incremental = '<c-s>',
                node_decremental = '<M-space>',
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ['<leader>a'] = '@parameter.inner',
                },
                swap_previous = {
                    ['<leader>A'] = '@parameter.inner',
                },
            },
        },
    }
end, 0)
--- }}}

-- completion and LSP {{{
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end
-- }}}

-- mason LSP {{{
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
local servers = {
    clangd = {},
    -- NOTE: pyright might not attach to python files, the problem is due to node or nodesj
    -- run: curl -sL https://deb.nodesource.com/setup_20.x | sudo bash -  && sudo apt-get update && sudo apt-get install nodejs
    -- eventually update the nodejs version
    pyright = {},
    html = { filetypes = { 'html', 'twig', 'hbs' } },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

require('mason-tool-installer').setup {
    ensure_installed = {
        'black',
        'isort',
        'flake8',
        'mypy',
    }
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end,
}

-- nvim-cmp setup
require("config.cmp")
-- }}}

-- Keychain {{{
-- document existing key chains
require('which-key').register {
    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
    ['<leader>g'] = { name = '[G]o', _ = 'which_key_ignore' },
    ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({
    ['<leader>'] = { name = 'VISUAL <leader>' },
    ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })
-- }}}
