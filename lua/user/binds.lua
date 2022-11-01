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
vim.keymap.set('n', '<leader>ff', ':lua require"telescope.builtin".find_files(require("telescope.themes").get_dropdown({ previewer = false }))<CR>', opts)
vim.keymap.set('n', '<leader>fg', ':lua require"telescope.builtin".live_grep(require("telescope.themes").get_dropdown({ previewer = false }))<CR>', opts)
vim.keymap.set('n', '<leader>fb', ':lua require"telescope.builtin".buffers(require("telescope.themes").get_dropdown({ previewer = false }))<CR>', opts)
vim.keymap.set('n', '<leader>fh', ':lua require"telescope.builtin".help_tags(require("telescope.themes").get_dropdown({ previewer = false }))<CR>', opts)

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

-- nvim-tree
map('n', '<Leader>nn', ':NvimTreeToggle<CR>')
