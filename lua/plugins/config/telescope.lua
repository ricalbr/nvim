local data = assert(vim.fn.stdpath 'data') --[[@as string]]
local icons = require 'plugins.config.icons'

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
    undo = true,
    fzf = true,
    history = { path = data, limit = 100 },
    ['ui-select'] = { require('telescope.themes').get_dropdown {} },
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
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
