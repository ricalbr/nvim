-- local builtin = require 'telescope.builtin'
-- local function telescope_live_grep_open_files()
--   builtin.live_grep {
--     grep_open_files = true,
--     prompt_title = 'Live Grep in Open Files',
--   }
-- end

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  keys = {
    { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[/] Fuzzily search in current buffer' },
    { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
    { '<leader>?', '<Cmd>Telescope oldfiles<CR>', { desc = '[?] Find recently opened files' } },
    { '<leader>u', '<cmd>Telescope undo<CR>', { desc = '[U]ndo history' } },
    { '<leader>gf', '<Cmd>Telescope git_files<CR>', { desc = 'Search [G]it [F]iles' } },
    { '<leader>gt', '<Cmd>Telescope tags<CR>', { desc = '[G]o to C[T]ags (telescope)', noremap = true } },
    -- { '<leader>s/', 'telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' }},
    { '<leader>sb', '<Cmd>Telescope buffers<CR>', { desc = '[ ] Find existing buffers' } },
    { '<leader>sd', '<Cmd>Telescope diagnostics<CR>', { desc = '[S]earch [D]iagnostics' } },
    { '<leader>sf', '<Cmd>Telescope find_files<CR>', { desc = '[S]earch [F]iles' } },
    { '<leader>sg', '<Cmd>Telescope live_grep<CR>', { desc = '[S]earch by [G]rep' } },
    { '<leader>sh', '<Cmd>Telescope help_tags<CR>', { desc = '[S]earch [H]elp' } },
    { '<leader>sr', '<Cmd>Telescope resume<CR>', { desc = '[S]earch [R]esume' } },
    { '<leader>sw', '<Cmd>Telescope grep_string<CR>', { desc = '[S]earch current [W]ord' } },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      -- only load if `make` is available. make sure you have the system requirements installed.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-smart-history.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'debugloop/telescope-undo.nvim',
  },
  opts = function()
    require('plenary.filetype').add_table {
      extension = {
        ['pgm'] = 'gcode',
        ['gcode'] = 'gcode',
        ['g'] = 'gcode',
        ['ngc'] = 'gcode',
      },
    }
  end,
  config = function()
    require 'config.telescope'
  end,
}

-- -- See `:help telescope.builtin`
