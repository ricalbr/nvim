local data = assert(vim.fn.stdpath 'data') --[[@as string]]
local icons = require 'config.icons'

require('telescope').setup {
  defaults = {
    file_ignore_patterns = { 'dune.lock' },
    prompt_prefix = ' ',
    selection_caret = icons.ui.ChevronRight .. ' ',
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
  },
  pickers = {
    live_grep = { theme = 'dropdown' },
    grep_string = { theme = 'dropdown' },
    find_files = { theme = 'dropdown', previewer = false },
    buffers = { theme = 'dropdown', previewer = false, initial_mode = 'normal' },
    lsp_references = { theme = 'dropdown', initial_mode = 'normal' },
    lsp_definitions = { theme = 'dropdown', initial_mode = 'normal' },
    lsp_declarations = { theme = 'dropdown', initial_mode = 'normal' },
    lsp_implementations = { theme = 'dropdown', initial_mode = 'normal' },
  },
  extensions = {
    wrap_results = true,
    undo = {},
    fzf = {},
    history = {
      path = data,
      limit = 100,
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {},
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'smart_history')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'undo')

local builtin = require 'telescope.builtin'
local function telescope_live_grep_open_files()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<cr>', { desc = '[U]ndo history' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>gt', builtin.tags, { desc = '[G]o to C[T]ags (telescope)', noremap = true })
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
