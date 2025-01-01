-- init.lua
-- @ricalbr

-- set <space> as the leader key
--  NOTE: must happen before plugins are required (otherwise wrong leader will be used)
-- Inizia a registrare il profilo
vim.cmd [[profile start ~/.config/nvim/nvim-profile.log]]

-- Profilare tutte le funzioni
vim.cmd [[profile func *]]

-- Profilare tutti i file
vim.cmd [[profile file *]]

require 'core'
require 'core.keymaps'

-- lazy.nvim {{{
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
  'tpope/vim-repeat',
  'anuvyklack/pretty-fold.nvim',
  'nvim-lualine/lualine.nvim',
  { 'nathom/filetype.nvim' },
  { 'numToStr/Comment.nvim', opts = {} },
  { 'kylechui/nvim-surround', opts = {} },
  -- { 'folke/which-key.nvim',        opts = {}, },
  -- { 'folke/twilight.nvim', opts = {} },
  { 'nvim-tree/nvim-web-devicons', opts = {} },
  { 'stevearc/oil.nvim', opts = {}, dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'lewis6991/gitsigns.nvim', event = 'BufEnter', cmd = 'Gitsigns' },
  { 'windwp/nvim-autopairs', event = 'VeryLazy' },
  { 'andymass/vim-matchup', event = 'VeryLazy' },
  {
    'folke/zen-mode.nvim',
    event = 'VeryLazy',
    opts = {
      window = {
        backdrop = 0.5, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 120, -- width of the Zen window
        height = 1, -- height of the Zen window
        options = {
          -- signcolumn = "no",      -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false, -- disable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = '0', -- disable fold column
          list = false, -- disable whitespace characters
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
        },
        twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = true }, -- disables git signs
      },
    },
  },

  -- {
  --   'vimwiki/vimwiki',
  --   event = 'VeryLazy',
  --   init = function()
  --     vim.g.vimwiki_list = {
  --       {
  --         path = '~/notes',
  --         syntax = 'markdown',
  --         ext = '.md',
  --       },
  --     }
  --     vim.g.vimwiki_global_ext = 0
  --   end,
  -- },

  {
    'neovim/nvim-lspconfig', -- LSP Configuration & Plugins
    event = 'LspAttach',
    dependencies = {
      { 'williamboman/mason.nvim', event = 'LspAttach' }, -- automatically install lsps to stdpath for neovim
      { 'williamboman/mason-lspconfig.nvim', event = 'LspAttach' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim', event = 'LspAttach' },
      { 'glepnir/lspsaga.nvim', event = 'LspAttach' },
      { 'j-hui/fidget.nvim', event = 'BufRead', opts = {} },
      'folke/neodev.nvim',
    },
  },

  {
    'hrsh7th/nvim-cmp', -- autocompletion
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        -- dependencies = {
        --     {
        --         'rafamadriz/friendly-snippets',
        --         config = function()
        --             require('luasnip.loaders.from_vscode').lazy_load()
        --         end,
        --     },
        -- },
      },
      { 'saadparwaiz1/cmp_luasnip', event = 'InsertEnter' },
      { 'hrsh7th/cmp-nvim-lsp', event = 'InsertEnter' },
      { 'hrsh7th/cmp-path', event = 'InsertEnter' },
      { 'hrsh7th/cmp-emoji', event = 'InsertEnter' },
      -- { 'hrsh7th/cmp-cmdline', event = 'InsertEnter' },
      -- { 'hrsh7th/cmp-buffer', event = 'InsertEnter' },
      -- { 'hrsh7th/cmp-nvim-lua' },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- fuzzy finder algorithm which requires local dependencies to be built. only load if `make` is available. make sure you have the system requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  { 'nvimtools/none-ls.nvim', dependencies = { 'nvimtools/none-ls-extras.nvim', 'nvim-lua/plenary.nvim' } },

  {
    -- highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.3', -- last version compatible with Nvim 0.9
    event = 'BufRead',
    after = 'vim-matchup',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
}, {})

require 'impatient' -- improve plugin performances
require 'nvim-web-devicons'
-- }}}

-- colorscheme {{{
vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitSignsDelete' })
vim.api.nvim_create_augroup('UpdateGutter', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'UpdateGutter',
  pattern = '*',
  callback = function()
    vim.cmd [[highlight ColorColumn guibg=#000000]]
    vim.cmd [[highlight GitSignsAdd guifg=#006900]]
    vim.cmd [[highlight GitSignsChange guifg=#FFFF00]]
    vim.cmd [[highlight GitSignsDelete guifg=#FF0000]]
    vim.cmd [[highlight GitSignsChangedelete guifg=#FF0000]]
    vim.cmd [[highlight GitSignsTopdelete guifg=#FF0000]]
    vim.cmd [[highlight MatchParen  cterm=bold gui=bold guifg=#F09EBF guibg=#1c1c1c ]]
  end,
})
vim.cmd 'colorscheme lunaperche'

require('lualine').setup {
  options = {
    theme = 'iceberg_dark',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'filetype' },
    lualine_y = { 'branch', 'diagnostics' },
  },
  inactive_sections = {
    lualine_b = { 'filename' },
    lualine_c = { '' },
  },
  extensions = { 'quickfix', 'man', 'fugitive' },
}
-- }}}

-- treesitter {{{
-- defer treesitter setup after first render to improve startup time
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'lua', 'python', 'vimdoc', 'latex', 'vim', 'bash', 'norg' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'org' },
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
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
      matchup = { enable = true },
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

require('mason').setup {
  ui = {
    border = 'rounded',
  },
}
require('mason-lspconfig').setup()
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
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
-- }}}

-- plugin setup {{{
local icons = require 'config.icons'
-- cmp {{{
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
  return
else
  require('luasnip.loaders.from_lua').lazy_load { paths = { '~/.config/nvim/lua/snippets/' } }
end

vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
vim.api.nvim_set_hl(0, 'CmpItemKindTabnine', { fg = '#CA42F0' })
vim.api.nvim_set_hl(0, 'CmpItemKindEmoji', { fg = '#FDE030' })

local check_backspace = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
        -- require("neotab").tabout()
      else
        fallback()
        -- require("neotab").tabout()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  formatting = {
    expandable_indicator = true,
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = icons.kind[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = '',
        nvim_lua = '',
        luasnip = '',
        buffer = '',
        path = '',
        emoji = '',
      })[entry.source.name]

      if entry.source.name == 'emoji' then
        vim_item.kind = icons.misc.Smiley
        vim_item.kind_hl_group = 'CmpItemKindEmoji'
      end

      if entry.source.name == 'cmp_tabnine' then
        vim_item.kind = icons.misc.Robot
        vim_item.kind_hl_group = 'CmpItemKindTabnine'
      end

      return vim_item
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'cmp_tabnine' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'emoji' },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = {
      border = 'rounded',
      scrollbar = false,
    },
    documentation = {
      border = 'rounded',
    },
  },
  experimental = {
    ghost_text = false,
  },
}
-- }}}
-- none-ls {{{
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local null_ls = require 'null-ls'
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with { extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' } },
    formatting.black.with { extra_args = { '--fast', '--skip-string-normalization', '--line-length=120' } },
    formatting.isort,
    -- diagnostics.flake8.with { extra_args = { '--max-line-length=120' } },
    require('none-ls.diagnostics.flake8').with { extra_args = { '--max-line-length', '120' } },
    formatting.stylua,
    formatting.clang_format,
    diagnostics.clazy,
    null_ls.builtins.completion.spell,
  },
  on_attach = function(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
          -- vim.lsp.buf.formatting_sync() -- DEPRECATED
        end,
      })
    end
  end,
}

-- }}}
-- telescope {{{
local actions = require 'telescope.actions'
require('telescope').setup {
  defaults = {
    prompt_prefix = ' ',
    selection_caret = icons.ui.ChevronRight .. ' ',
    entry_prefix = '   ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    path_display = { 'smart' },
    color_devicons = true,
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--glob=!.git/',
    },

    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,

        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
      n = {
        ['<esc>'] = actions.close,
        ['j'] = actions.move_selection_next,
        ['k'] = actions.move_selection_previous,
        ['q'] = actions.close,
      },
    },
  },
  pickers = {
    live_grep = {
      theme = 'dropdown',
    },

    grep_string = {
      theme = 'dropdown',
    },

    find_files = {
      theme = 'dropdown',
      previewer = false,
    },

    buffers = {
      theme = 'dropdown',
      previewer = false,
      initial_mode = 'normal',
      mappings = {
        i = {
          ['<C-d>'] = actions.delete_buffer,
        },
        n = {
          ['dd'] = actions.delete_buffer,
        },
      },
    },

    planets = {
      show_pluto = true,
      show_moon = true,
    },

    colorscheme = {
      enable_preview = true,
    },

    lsp_references = {
      theme = 'dropdown',
      initial_mode = 'normal',
    },

    lsp_definitions = {
      theme = 'dropdown',
      initial_mode = 'normal',
    },

    lsp_declarations = {
      theme = 'dropdown',
      initial_mode = 'normal',
    },

    lsp_implementations = {
      theme = 'dropdown',
      initial_mode = 'normal',
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- if the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- find the git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>gt', require('telescope.builtin').tags, { desc = '[G]o to C[T]ags (telescope)', noremap = true })
-- }}}
-- gitsigns {{{
require('gitsigns').setup {
  signs = {
    add = { text = icons.ui.BoldLineMiddle },
    change = { text = icons.ui.BoldLineMiddle },
    delete = { text = icons.ui.TriangleShortArrowRight },
    topdelete = { text = icons.ui.TriangleShortArrowRight },
    changedelete = { text = icons.ui.TriangleShortArrowRight },
    untracked = { text = '┆' },
  },
  signs_staged = {
    add = { text = icons.ui.BoldLineMiddle },
    change = { text = icons.ui.BoldLineMiddle },
    delete = { text = icons.ui.TriangleShortArrowRight },
    topdelete = { text = icons.ui.TriangleShortArrowRight },
    changedelete = { text = icons.ui.TriangleShortArrowRight },
    untracked = { text = '┆' },
  },

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map({ 'n', 'v' }, ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Jump to next hunk' })

    map({ 'n', 'v' }, '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Jump to previous hunk' })

    -- Actions
    -- visual mode
    map('v', '<leader>hs', function()
      gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'stage git hunk' })
    map('v', '<leader>hr', function()
      gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'reset git hunk' })
    -- normal mode
    map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
    map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
    map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
    map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
    map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
    map('n', '<leader>hb', function()
      gs.blame_line { full = false }
    end, { desc = 'git blame line' })
    map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
    map('n', '<leader>hD', function()
      gs.diffthis '~'
    end, { desc = 'git diff against last commit' })

    -- Toggles
    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
    map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
  end,

  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'rounded',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  -- yadm = { enable = false, },
}
-- }}}
-- filetype {{{
require('filetype').setup {
  overrides = { extensions = { pgm = 'gcode', gcode = 'gcode', g = 'gcode', ngc = 'gcode' } },
}
-- }}}
-- match-up {{{
require('match-up').setup { opts = {} }
-- }}}
-- oil {{{
require('oil').setup {
  default_file_explorer = true,
  columns = { 'icon' },
  buf_options = {
    buflisted = false,
    bufhidden = 'hide',
  },
  win_options = {
    wrap = false,
    signcolumn = 'no',
    cursorcolumn = false,
    foldcolumn = '0',
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = 'nvic',
  },
  delete_to_trash = false,
  skip_confirm_for_simple_edits = false,
  prompt_save_on_select_new_entry = true,
  cleanup_delay_ms = 2000,
  -- lsp_rename_autosave = false,
  lsp_file_methods = { autosave_changes = false },
  constrain_cursor = 'editable',
  keymaps = {
    ['g?'] = 'actions.show_help',
    ['<CR>'] = 'actions.select',
    ['<C-v>'] = 'actions.select_vsplit',
    ['<C-h>'] = 'actions.select_split',
    ['<C-t>'] = 'actions.select_tab',
    ['<C-p>'] = 'actions.preview',
    ['<C-c>'] = 'actions.close',
    ['<C-l>'] = 'actions.refresh',
    ['-'] = 'actions.parent',
    ['_'] = 'actions.open_cwd',
    ['`'] = 'actions.cd',
    ['~'] = 'actions.tcd',
    ['gs'] = 'actions.change_sort',
    ['gx'] = 'actions.open_external',
    ['g.'] = 'actions.toggle_hidden',
    ['g\\'] = 'actions.toggle_trash',
  },
  use_default_keymaps = true,
  view_options = {
    show_hidden = false,
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, '.')
    end,
    is_always_hidden = function(name, bufnr)
      return false
    end,
    sort = {
      { 'type', 'asc' },
      { 'name', 'asc' },
    },
  },
  float = {
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = 'rounded',
    win_options = {
      winblend = 0,
    },
    override = function(conf)
      return conf
    end,
  },
  preview = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = 0.9,
    min_height = { 5, 0.1 },
    height = nil,
    border = 'rounded',
    win_options = {
      winblend = 0,
    },
    update_on_cursor_moved = true,
  },
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = 'rounded',
    minimized_border = 'none',
    win_options = {
      winblend = 0,
    },
  },
}

vim.keymap.set('n', '<leader>nn', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
-- }}}
-- pretty-fold {{{
require('pretty-fold').setup {
  sections = {
    left = { 'content' },
    right = {
      ' ',
      'number_of_folded_lines',
      ' ',
      function(config)
        return config.fill_char:rep(3)
      end,
    },
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
}
-- }}}
-- autopairs {{{
require('nvim-autopairs').setup {
  enable_check_bracket_line = false, -- don't add pairs if it already has a close pair in the same line
  ignored_next_char = '[%w%.]', -- will ignore alphanumeric and `.` symbol
  check_ts = true, -- use treesitter to check for a pair.
  disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
}
-- }}}
-- keychain {{{
-- document existing key chains
-- require('which-key').register {
--     ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--     ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--     ['<leader>g'] = { name = '[G]o', _ = 'which_key_ignore' },
--     ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
--     ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--     ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--     ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
--     ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
-- }
-- -- register which-key VISUAL mode
-- -- required for visual <leader>hs (hunk stage) to work
-- require('which-key').register({
--     ['<leader>'] = { name = 'VISUAL <leader>' },
--     ['<leader>h'] = { 'Git [H]unk' },
-- }, { mode = 'v' })
-- -- }}}
-- }}}
