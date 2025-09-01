-- key bindings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- keymaps for better default experience
keymap('i', 'jk', '<Esc><Esc>', opts)
keymap('n', '\\', '<cmd>bd<CR>', opts)

-- map C-s to save the file, in all the modes
keymap('n', '<C-S>', '<Cmd>silent! update | redraw<CR>', { desc = 'Save', })
keymap({ 'i', 'x' }, '<C-S>', '<Esc><Cmd>silent! update | redraw<CR>', { desc = 'Save and go to Normal mode', })

-- keep searches centered on screen
local keys_to_center = { 'n', 'N', '*', '#', 'g*', 'g#', '{', '}', '<C-u>', '<C-d>' }
for _, key in ipairs(keys_to_center) do
    keymap('n', key, key .. 'zz', opts)
end

-- toggle spell
keymap('n', '<leader>ss', '<Cmd>set spell!<CR>', { desc = 'Toggle spell checking' })

-- join lines keeping the cursor position
keymap('n', 'J', 'mzJ`z', opts)

-- move vertically by visual line (don't skip wrapped lines)
keymap({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true, silent = true })
keymap({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true, silent = true })

-- Copy/paste with system clipboard
keymap('x', 'p', [["_dP]]) -- paste without overriding the register
keymap({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
keymap('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })
keymap('x', 'gp', '"+P', { desc = 'Paste from system clipboard' }) -- paste in visual with `P` to not copy selected text (`:h v_P`)

--

-- Search inside visually highlighted text. Use `silent = false` for it to make effect immediately.
keymap('x', 'g/', '<esc>/\\%V', { silent = false, desc = 'Search inside visual selection' })

-- retain visual selection after `>` or `<`
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- -- switch between splits using ctrl + {h,j,k,l}
-- keymap({ 'i', 'n', 't' }, '<C-h>', '<C-\\><C-N><C-w>h', opts)
-- keymap({ 'i', 'n', 't' }, '<C-j>', '<C-\\><C-N><C-w>j', opts)
-- keymap({ 'i', 'n', 't' }, '<C-k>', '<C-\\><C-N><C-w>k', opts)
-- keymap({ 'i', 'n', 't' }, '<C-l>', '<C-\\><C-N><C-w>l', opts)

-- no K or arrow keys
keymap('n', '<K>', '<NOP>', opts)
local keys_to_disable = { '<Down>', '<Up>', '<Left>', '<Right>' }
for _, key in ipairs(keys_to_disable) do
    keymap({ 'n', 'i' }, key, '<NOP>', opts)
end

-- diagnostic keymaps
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfix list' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- stylua: ignore start
keymap('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
keymap('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
keymap('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
keymap('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
keymap('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
keymap('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- fzf-lua
keymap('n', '<leader>sf', '<Cmd>FzfLua files<CR>', { desc = 'Search Files' })
keymap('n', '<leader>sg', '<Cmd>FzfLua live_grep<CR>', { desc = 'Search Grep' })
keymap('n', '<leader>sm', '<Cmd>FzfLua marks<CR>', { desc = 'Search Marks' })
keymap('n', '<leader>sk', '<Cmd>FzfLua keymaps<CR>', { desc = 'Search Keymaps' })
keymap('n', '<leader>sb', '<Cmd>FzfLua buffers<CR>', { desc = 'Search Buffers' })
keymap('n', '<leader>sw', '<Cmd>FzfLua grep_cword<CR>', { desc = 'Search Word' })
keymap('n', '<leader>sh', '<Cmd>FzfLua helptags<CR>', { desc = 'Search Help Tags' })
keymap('n', '<leader>sp', '<Cmd>FzfLua spell_suggest<CR>', { desc = 'Spelling Suggestions' })
keymap('n', '<leader>gc', '<Cmd>FzfLua git_commits<CR>', { desc = 'Browse File Commits' })
keymap('n', '<leader>gs', '<Cmd>FzfLua git_status<CR>', { desc = 'Browse Git Status' })
keymap('n', '<leader>cd', '<Cmd>FzfLua lsp_definitions<CR>', { desc = 'Jump to Definition' })
keymap('n', '<leader>ci', '<Cmd>FzfLua lsp_implementations<CR>', { desc = 'Jump to Implementations' })
keymap('n', '<leader>cr', '<Cmd>FzfLua lsp_references <CR>', { desc = 'LSP References' })
keymap('n', '<leader><leader>', '<Cmd>FzfLua resume<CR>', { desc = 'Resume FZF search' })
-- stylua: ignore end

-- oil
keymap('n', '-', '<Cmd>Oil --float . <CR>', { desc = 'Open Oil on current working directory' })

-- remove unused package
local function pack_clean()
    local active_plugins = {}
    local unused_plugins = {}

    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end

    if #unused_plugins == 0 then
        print("No unused plugins.")
        return
    end

    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end

vim.keymap.set("n", "<leader>pc", pack_clean)
