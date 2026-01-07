-- python

-- basic settings
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.fileformat = 'unix'
vim.opt_local.textwidth = 120
vim.opt_local.foldlevel = 99
vim.opt_local.foldlevelstart = 99

-- run current file
vim.keymap.set("n", "<F7>", function()
    vim.cmd("update")
    vim.cmd("botright split | terminal python3 %")
end, { buffer = true, silent = true })
