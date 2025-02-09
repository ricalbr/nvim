-- colorscheme overrider
function ColorsSetup(color)
    color = color or 'rose-pine-moon'
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'MiniDiffSignAdd', { fg = '#57D75F' })
    vim.api.nvim_set_hl(0, 'MiniDiffSignChange', { fg = '#FFAF5F' })
    vim.api.nvim_set_hl(0, 'MiniDiffSignDelete', { fg = '#D75F5F' })
    -- vim.api.nvim_set_hl(0, 'MiniDiffOverAdd', { link = 'MiniDiffSignAdd' })
    vim.api.nvim_set_hl(0, 'MiniDiffOverChange', { link = 'MiniDiffSignChange' })
    vim.api.nvim_set_hl(0, 'MiniDiffOverContext', { link = 'MiniDiffSignChange' })
    vim.api.nvim_set_hl(0, 'MiniDiffOverDelete', { fg = '#000000', bg = '#D75F5F' })
    vim.api.nvim_set_hl(0, 'Visual', { link = 'Folded' })
    vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'SignColumn', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { fg = '#E0E0E0', bg = 'none', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual', { fg = '#458588', bg = 'none', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { fg = '#98971A', bg = 'none', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplace', { fg = '#B16286', bg = 'none', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { fg = '#D79921', bg = 'none', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeOther', { fg = '#E0E0E0', bg = 'none', bold = true })
end

return {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
        ColorsSetup()
    end,
}
