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
map('n', '<Space>', '<nop>', opts)
vim.g.mapleader = ' '
vim.b.mapleader = ' '

map('n', '\\', ':bd<CR>', opts)

-- juggling with files w/ telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fs', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- map('n', '<Leader>s', ':sfind *')
-- map('n', '<Leader>v', ':vert sfind *')
-- map('n', '<Leader>t', ':tabfind *')

map('n', '<Tab>', ':bnext<CR>', opts)
map('n', '<S-Tab>', ':bprevious<CR>', opts)
map('n', '<Leader>d', ':w !diff % -<CR>', opts)
map('n', '<Leader>r', ':retab<CR>', opts)

-- mapping C-S to save the file, in all the modes
map('n', '<C-s>', '<C-u>:Update<CR>', opts)
map('v', '<C-s>', '<C-c>:Update<CR>gv', opts)
map('i', '<C-s>', '<C-o>:Update<CR>', opts)

-- join lines keepin the cursor position
map('n', 'J', ':let p=getpos(".")<bar>join<bar>call setpos(".", p)<CR>', opts)

-- capital Y standard behaviour
map('n', 'Y', 'y$', opts)

-- move vertically by visual line (don't skip wrapped lines)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)

-- retain visual selection after `>` or `<`
map('v', '>', '>gv', opts)
map('v', '<', '<gv', opts)

-- move visual selection
map('x', 'J', ':move ">+1<CR>gv=gv"', opts)
map('x', 'K', ':move "<-2<CR>gv=gv"', opts)

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

-- " window management
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

