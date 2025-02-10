local spell = function()
    vim.wo.spell = true
    vim.bo.spellfile = vim.fn.expand '$HOME/.config/nvim/spell/en.utf-8.add'
    vim.bo.spelllang = 'en,it'
end
return spell
