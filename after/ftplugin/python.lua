-- python

-- buffer-local settings
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.fileformat = "unix"
vim.opt_local.textwidth = 120
vim.opt_local.foldlevel = 99
vim.opt_local.foldlevelstart = 99

-- terminal buffer
local python_term_buf = nil

local function run_python()
    vim.cmd("update")
    local file = vim.fn.expand("%:p")

    -- invalidate terminal if wiped
    if python_term_buf and not vim.api.nvim_buf_is_valid(python_term_buf) then
        python_term_buf = nil
    end

    local term_win = nil

    -- find existing terminal window
    if python_term_buf then
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == python_term_buf then
                term_win = win
                break
            end
        end
    end

    -- create terminal if not found
    if not term_win then
        vim.cmd("botright split")
        vim.cmd("terminal")
        python_term_buf = vim.api.nvim_get_current_buf()
        term_win = vim.api.nvim_get_current_win()
        vim.bo.bufhidden = "wipe"
    else
        vim.api.nvim_set_current_win(term_win)
    end

    -- send command
    vim.fn.chansend(
        vim.b.terminal_job_id,
        "python3 " .. vim.fn.shellescape(file) .. "\n"
    )

    -- scroll to bottom after output
    vim.defer_fn(function()
        if term_win and vim.api.nvim_win_is_valid(term_win) then
            vim.api.nvim_win_call(term_win, function()
                vim.cmd("normal! G")
            end)
        end
    end, 80)

    vim.cmd("wincmd p")
end

-- close terminal window
local function close_python_terminal()
    if not python_term_buf then return end
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == python_term_buf then
            vim.api.nvim_win_close(win, true)
            return
        end
    end
end

-- keymaps
vim.keymap.set("n", "<F7>", run_python, { buffer = true, silent = true })
vim.keymap.set("i", "<F7>", function()
    vim.cmd("stopinsert")
    run_python()
end, { buffer = true, silent = true })

-- close terminal in normal or terminal mode
vim.keymap.set({ "n", "t" }, "<leader>tc", close_python_terminal, { buffer = true, silent = true })
