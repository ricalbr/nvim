-- key bindings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- set leader key before anything else
keymap({ 'n', 'v' }, '<Space>', '', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- keymaps for better default experience
keymap('n', '\\', '<cmd> bd<CR>', opts)
keymap('n', '<Tab>', '<cmd> bnext<CR>', opts)
keymap('n', '<S-Tab>', '<cmd> bprevious<CR>', opts)
keymap('n', '<Esc><Esc>', '<cmd> noh<CR>', { desc = 'Deactivate search highlight', noremap = true, silent = true })

-- mapping C-s to save the file, in all the modes
keymap('n', '<C-s>', '<Esc> <cmd>Update<CR>', opts)
keymap('v', '<C-s>', '<Esc> <cmd>Update<CR>gv', opts)
keymap('i', '<C-s>', '<Esc> <cmd>Update<CR>', opts)

-- keep searches centered on screen
keymap('n', 'n', 'nzz', opts)
keymap('n', 'N', 'Nzz', opts)
keymap('n', '*', '*zz', opts)
keymap('n', '#', '#zz', opts)
keymap('n', 'g*', 'g*zz', opts)
keymap('n', 'g#', 'g#zz', opts)

-- join lines keepin the cursor position
keymap('n', 'J', '<cmd>let p=getpos(".")<bar>join<bar>call setpos(".", p)<CR>', opts)

-- move vertically by visual line (don't skip wrapped lines)
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- retain visual selection after `>` or `<`
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- argslist navigation
keymap('n', '[a', '<cmd>previous<CR>', opts)
keymap('n', ']a', '<cmd>next<CR>', opts)
keymap('n', '[A', '<cmd>first<CR>', opts)
keymap('n', ']A', '<cmd>last<CR>', opts)

-- paste without overriding the register
keymap('x', 'p', [["_dP]])

-- switch between splits using ctrl + {h,j,k,l}
keymap('i', '<C-h>', '<C-\\><C-N><C-w>h', opts)
keymap('i', '<C-j>', '<C-\\><C-N><C-w>j', opts)
keymap('i', '<C-k>', '<C-\\><C-N><C-w>k', opts)
keymap('i', '<C-l>', '<C-\\><C-N><C-w>l', opts)

keymap('n', '<C-h>', '<C-\\><C-N><C-w>h', opts)
keymap('n', '<C-j>', '<C-\\><C-N><C-w>j', opts)
keymap('n', '<C-k>', '<C-\\><C-N><C-w>k', opts)
keymap('n', '<C-l>', '<C-\\><C-N><C-w>l', opts)

keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- window management
keymap('n', '<Leader>0', '<C-w>=', opts)
keymap('n', '<Leader>+', '<cmd> vertical resize +10<CR>', opts)
keymap('n', '<Leader>-', '<cmd>  resize -10<CR>', opts)

-- vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
-- vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

-- no K or arrow keys
keymap('n', '<K>', '<NOP>', opts)
keymap('n', '<Down>', '<NOP>', opts)
keymap('n', '<Up>', '<NOP>', opts)
keymap('n', '<Left>', '<NOP>', opts)
keymap('i', '<Right>', '<NOP>', opts)
keymap('i', '<Down>', '<NOP>', opts)
keymap('i', '<Up>', '<NOP>', opts)
keymap('i', '<Left>', '<NOP>', opts)
keymap('i', '<Right>', '<NOP>', opts)

-- diagnostic keymaps
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<M-j>', '<cmd> cnext<CR>', { desc = 'Go to next quickfix list argument' })
keymap('n', '<M-k>', '<cmd> cprev<CR>', { desc = 'Go to previous quickfix list argument' })

-- change directory to cwd
keymap('n', '<leader>cd', '<cmd> cd %:h<CR>', opts)

-- notes
keymap('n', '<leader>ni', '<cmd> e $NOTES_DIR/index.md<CR>:cd $NOTES_DIR<CR>', opts)
keymap('n', '<leader>nt', '<cmd> silent !ctags -R . <CR> :redraw! <CR>', opts)
