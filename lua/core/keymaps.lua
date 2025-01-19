-- key bindings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- keymaps for better default experience
keymap('i', 'jk', '<Esc>', opts)
keymap('n', '\\', '<cmd>bd<CR>', opts)
keymap('n', '<Tab>', '<cmd>bnext<CR>', opts)
keymap('n', '<S-Tab>', '<cmd>bprevious<CR>', opts)
keymap('n', '<Esc><Esc>', '<cmd>noh<CR>', { desc = 'Deactivate search highlight', noremap = true, silent = true })

-- change directory to cwd
keymap('n', '<leader>cd', '<cmd>cd %:h<CR>', { noremap = true })

-- map C-s to save the file, in all the modes
keymap({ 'n', 'i' }, '<C-s>', '<Esc><cmd>update<CR>', opts)
keymap('v', '<C-s>', '<Esc><cmd>update<CR>gv', opts)

-- select all text
keymap('n', '<leader>aa', 'ggVG', { desc = 'Select all', noremap = true, silent = true })

-- keep searches centered on screen
local keys_to_center = { 'n', 'N', '*', '#', 'g*', 'g#' }
for _, key in ipairs(keys_to_center) do
  keymap('n', key, key .. 'zz', opts)
end

-- join lines keepin the cursor position
keymap('n', 'J', '<cmd>let p=getpos(".")<bar>join<bar>call setpos(".", p)<CR>', opts)

-- move vertically by visual line (don't skip wrapped lines)
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- retain visual selection after `>` or `<`
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- paste without overriding the register
keymap('x', 'p', [["_dP]])

-- switch between splits using ctrl + {h,j,k,l}
keymap({ 'i', 'n', 't' }, '<C-h>', '<C-\\><C-N><C-w>h', opts)
keymap({ 'i', 'n', 't' }, '<C-j>', '<C-\\><C-N><C-w>j', opts)
keymap({ 'i', 'n', 't' }, '<C-k>', '<C-\\><C-N><C-w>k', opts)
keymap({ 'i', 'n', 't' }, '<C-l>', '<C-\\><C-N><C-w>l', opts)

-- no K or arrow keys
keymap('n', '<K>', '<NOP>', opts)
local keys_to_disable = { '<Down>', '<Up>', '<Left>', '<Right>' }
for _, key in ipairs(keys_to_disable) do
  keymap({ 'n', 'i' }, key, '<NOP>', opts)
end

-- diagnostic keymaps
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- keymap('n', '<M-j>', '<cmd>cnext<CR>', { desc = 'Go to next quickfix list argument' })
-- keymap('n', '<M-k>', '<cmd>cprev<CR>', { desc = 'Go to previous quickfix list argument' })
-- keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' }) -- use mini.jump
-- keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' }) -- use mini.jump

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>/', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>?', '<Cmd>Telescope oldfiles<CR>', { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<CR>', { desc = '[U]ndo history' })
vim.keymap.set('n', '<leader>gf', '<Cmd>Telescope git_files<CR>', { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>gt', '<Cmd>Telescope tags<CR>', { desc = '[G]o to C[T]ags (telescope)', noremap = true })
vim.keymap.set('n', '<leader>sb', '<Cmd>Telescope buffers<CR>', { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sd', '<Cmd>Telescope diagnostics<CR>', { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sf', '<Cmd>Telescope find_files<CR>', { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', '<Cmd>Telescope live_grep<CR>', { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sh', '<Cmd>Telescope help_tags<CR>', { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sr', '<Cmd>Telescope resume<CR>', { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>ss', '<Cmd>Telescope builtin<CR>', { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', '<Cmd>Telescope grep_string<CR>', { desc = '[S]earch current [W]ord' })
-- telescope
