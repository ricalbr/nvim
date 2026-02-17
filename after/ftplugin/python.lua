-- python

-- python ftplugin

-- basic buffer-local settings
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.fileformat = "unix"
vim.opt_local.textwidth = 120
vim.opt_local.foldlevel = 99
vim.opt_local.foldlevelstart = 99

-- store terminal buffer id
local python_term_buf = nil

local function run_python()
    -- save current file
    vim.cmd("update")

    -- get absolute path of current file
    local file = vim.fn.expand("%:p")

    -- check if terminal buffer is still valid
    if python_term_buf and not vim.api.nvim_buf_is_valid(python_term_buf) then
        python_term_buf = nil
    end

    -- try to find an existing window showing the terminal
    if python_term_buf then
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == python_term_buf then
                vim.api.nvim_set_current_win(win)
                goto send
            end
        end
    end

    -- otherwise create a new terminal window
    vim.cmd("botright split")
    vim.cmd("terminal")
    python_term_buf = vim.api.nvim_get_current_buf()

    -- ensure terminal buffer is wiped when closed
    vim.bo.bufhidden = "wipe"

    ::send::
    -- send command to terminal
    vim.fn.chansend(
        vim.b.terminal_job_id,
        "python3 " .. vim.fn.fnameescape(file) .. "\n"
    )

    -- go back to previous window
    vim.cmd("wincmd p")
end

-- keymaps
vim.keymap.set("n", "<F7>", run_python, { buffer = true, silent = true })
vim.keymap.set("i", "<F7>", function()
    vim.cmd("stopinsert")
    run_python()
end, { buffer = true, silent = true })
