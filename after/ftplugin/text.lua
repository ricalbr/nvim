-- text files

vim.opt_local.spell = true
vim.opt_local.spelllang = { "en", "it" }

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.showbreak = "↳ "
vim.opt_local.conceallevel = 0

-- tabs & indentation suited for prose
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.scrolloff = 999

-- disable auto-comment continuation
vim.opt_local.formatoptions:remove({ "c", "r", "o" })

-- highlight search minimally
vim.opt_local.hlsearch = false

-- Goyo keymap
vim.keymap.set('n', '<Leader>ml', '<Cmd>Goyo<CR>', { desc = 'Toggle Goyo' })
