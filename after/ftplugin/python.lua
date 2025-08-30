-- python

-- basic settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.fileformat = 'unix'
vim.opt.textwidth = 120
-- vim.wo.colorcolumn = 121
-- vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 99

vim.opt.makeprg = "python3 %"
vim.keymap.set("n", "<F7>", ":update<CR>:make<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<F7>", "<ESC>:update<CR>:make<CR>", { noremap = true, silent = true })


vim.opt_local.makeprg = "python3 %"

local opts = { noremap = true, silent = true, desc = "Run Python file" }
vim.keymap.set("n", "<F7>", ":update<CR>:make<CR>", opts)
vim.keymap.set("i", "<F7>", "<ESC>:update<CR>:make<CR>", opts)

-- Function to pick a virtualenv and set makeprg
local function pick_venv()
    -- Change this to your venv base dir (example: ~/.virtualenvs or conda envs path)
    local venvs_path = vim.fn.expand("~/.venvs")
    local venvs = vim.fn.globpath(venvs_path, "*", 0, 1)

    if #venvs == 0 then
        vim.notify("No virtualenvs found in " .. venvs_path, vim.log.levels.WARN)
        return
    end

    -- Let user choose from list
    local choice = vim.fn.inputlist(vim.list_extend({ "Select a virtualenv:" }, venvs))
    if choice < 1 or choice > #venvs then
        return
    end

    local venv = venvs[choice]
    local python_path = venv .. "/bin/python"

    -- Update makeprg for this buffer
    vim.opt_local.makeprg = python_path .. " %"

    vim.notify("Using Python: " .. python_path, vim.log.levels.INFO)
end

-- Keymap to pick venvenvvs
vim.keymap.set("n", "<leader>pv", pick_venv, { noremap = true, silent = true, desc = "Pick Python venv" })
