-- key bindings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- set <space> as the leader key
--  NOTE: must happen before plugins are required (otherwise wrong leader will be used)
keymap({ 'n', 'v' }, '<Space>', '', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- keymaps for better default experience
keymap('i', 'jk', '<Esc><Esc>', opts)
keymap('n', '\\', '<cmd>bd<CR>', opts)
keymap({ 'i', 'n', 's' }, '<Esc>', function()
    vim.cmd 'noh'
    return '<esc>'
end, { expr = true, desc = 'Escape and Clear hlsearch' })

-- change directory to cwd
keymap('n', '<leader>cd', '<cmd>cd %:h<CR>', { noremap = true })

-- map C-s to save the file, in all the modes
keymap({ 'n', 'i' }, '<C-s>', '<Esc><cmd>update<CR>', opts)
keymap('v', '<C-s>', '<Esc><cmd>update<CR>gv', opts)

-- select all text
keymap('n', '<leader>aa', 'ggVG<c-$>', { desc = 'Select all', noremap = true, silent = true })

-- keep searches centered on screen
local keys_to_center = { 'n', 'N', '*', '#', 'g*', 'g#', '{', '}', '<C-u>', '<C-d>' }
for _, key in ipairs(keys_to_center) do
    keymap('n', key, key .. 'zz', opts)
end

-- join lines keepin the cursor position
keymap('n', 'J', 'mzJ`z', opts)

-- move vertically by visual line (don't skip wrapped lines)
keymap({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- stylua: ignore start
keymap('n',  'n',  "'Nn'[v:searchforward].'zv'",  {  expr  =  true,  desc  =  'Next  Search  Result'  })
keymap('x',  'n',  "'Nn'[v:searchforward]",       {  expr  =  true,  desc  =  'Next  Search  Result'  })
keymap('o',  'n',  "'Nn'[v:searchforward]",       {  expr  =  true,  desc  =  'Next  Search  Result'  })
keymap('n',  'N',  "'nN'[v:searchforward].'zv'",  {  expr  =  true,  desc  =  'Prev  Search  Result'  })
keymap('x',  'N',  "'nN'[v:searchforward]",       {  expr  =  true,  desc  =  'Prev  Search  Result'  })
keymap('o',  'N',  "'nN'[v:searchforward]",       {  expr  =  true,  desc  =  'Prev  Search  Result'  })

-- no K or arrow keys
keymap('n', '<K>', '<NOP>', opts)
local keys_to_disable = { '<Down>', '<Up>', '<Left>', '<Right>' }
for _, key in ipairs(keys_to_disable) do
    keymap({ 'n', 'i' }, key, '<NOP>', opts)
end

-- diagnostic keymaps
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- fzf-lua
keymap('n',  '<leader>sf',        '<Cmd>FzfLua  files<CR>',            { desc  =  'FZF Files' })
keymap('n',  '<leader>sg',        '<Cmd>FzfLua  live_grep<CR>',        { desc  =  'FZF Grep' })
keymap('n',  '<leader>mk',        '<Cmd>FzfLua  marks<CR>',            { desc  =  'Marks' })
keymap('n',  '<leader>sk',        '<Cmd>FzfLua  keymaps<CR>',          { desc  =  'Keymaps' })
keymap('n',  '<leader>sb',        '<Cmd>FzfLua  buffers<CR>',          { desc  =  'FZF Buffers' })
keymap('n',  '<leader>sw',        '<Cmd>FzfLua  grep_cword<CR>',       { desc  =  'FZF Word' })
keymap('n',  '<leader>sh',        '<Cmd>FzfLua  helptags<CR>',         { desc  =  'Help Tags' })
keymap('n',  '<leader>gc',        '<Cmd>FzfLua  git_bcommits<CR>',     { desc  =  'Browse File Commits' })
keymap('n',  '<leader>gs',        '<Cmd>FzfLua  git_status<CR>',       { desc  =  'Git Status' })
keymap('n',  '<leader>sp',        '<Cmd>FzfLua  spell_suggest<CR>',    { desc  =  'Spelling Suggestions' })
keymap('n',  '<leader>cj',        '<Cmd>FzfLua  lsp_definitions<CR>',  { desc  =  'Jump to Definition' })
keymap('n',  '<leader>cr',        '<Cmd>FzfLua  lsp_references',       { desc  =  'LSP References' })
keymap('n',  '<leader><leader>',  '<Cmd>FzfLua  resume<CR>',           { desc  =  'FZF resume search' })
-- stylua: ignore end

-- which-key
keymap('n', '<leader>wk', '<Cmd>WhichKey<CR>', { desc = 'Which-key' })

-- oil
keymap('n', '-', '<Cmd>Oil --float .. <CR>', { desc = 'Open Oil on parent directory' })
