local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
    return vim.api.nvim_create_augroup('lazynvim_' .. name, { clear = true })
end

-- dont list quickfix buffers
autocmd('Filetype', {
    group = augroup 'quickfix',
    pattern = 'qf',
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- map q to :close for utility buffers
autocmd({ 'FileType' }, {
    group = augroup 'close_with_q',
    pattern = {
        'netrw',
        'Jaq',
        'qf',
        'git',
        'help',
        'man',
        'lspinfo',
        'oil',
        'spectre_panel',
        'lir',
        'DressingSelect',
        'tsplayground',
        '',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set('n', 'q', function()
                vim.cmd 'close'
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = 'Quit buffer',
            })
        end)
    end,
})

-- warn if buffer has been modified outside of vim
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = augroup 'checktime',
    callback = function()
        if vim.o.buftype ~= 'nofile' then
            vim.cmd 'checktime'
        end
    end,
})

-- highlight on yank
autocmd('TextYankPost', {
    group = augroup 'highlight_yank',
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})

-- go to last loc when opening a buffer
autocmd('BufReadPost', {
    group = augroup 'last_loc',
    callback = function(event)
        local exclude = { 'gitcommit' }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- don't auto comment new line
autocmd({ 'BufWinEnter' }, {
    group = augroup 'no_comment_newline',
    callback = function()
        vim.cmd 'set formatoptions-=cro'
    end,
})

-- enable spell checking for certain file types
autocmd('FileType', {
    group = augroup 'wrap_spell',
    pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- overload q and w command
vim.api.nvim_command 'command! Q q'
vim.api.nvim_command 'command! W w'
vim.api.nvim_command 'command! Wq wq'

-- write file with sudo
vim.cmd.cnoreabbrev { 'w!!', 'w !sudo tee > /dev/null %<CR>' }
