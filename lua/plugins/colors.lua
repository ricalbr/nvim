local function get_rose_pine_colors()
    local ok, palette = pcall(require, 'rose-pine.palette')
    if not ok then
        vim.notify('rose-pine palette not found', vim.log.levels.ERROR)
        return {}
    end

    return {
        red = palette.love, -- Red color in rose-pine
        green = palette.leaf, -- Green color
        blue = palette.foam, -- Blue color
        yellow = palette.gold, -- Yellow color
        cyan = palette.iris, -- Cyan/blue mix
        magenta = palette.rose, -- Magenta
        black = palette.base, -- Background
        white = palette.text, -- Foreground
    }
end

-- colorscheme overrider
function ColorsSetup(color)
    color = color or 'rose-pine'
    vim.cmd.colorscheme(color)

    local colors = get_rose_pine_colors()
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'MiniDiffSignAdd', { fg = colors.green })
    vim.api.nvim_set_hl(0, 'MiniDiffSignChange', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, 'MiniDiffSignDelete', { fg = colors.red })
    -- vim.api.nvim_set_hl(0, 'MiniDiffOverAdd', { link = 'MiniDiffSignAdd' })
    vim.api.nvim_set_hl(0, 'MiniDiffOverChange', { link = 'MiniDiffSignChange' })
    vim.api.nvim_set_hl(0, 'MiniDiffOverContext', { link = 'MiniDiffSignChange' })
    vim.api.nvim_set_hl(0, 'MiniDiffOverDelete', { fg = colors.black, bg = colors.red })
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#000000', bg = 'none' })
    vim.api.nvim_set_hl(0, 'TabLineFill', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { fg = colors.blue, bg = 'none', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual', { fg = colors.magenta, bg = 'none', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { fg = colors.yellow, bg = 'none', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplace', { fg = colors.red, bg = 'none', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { fg = colors.cyan, bg = 'none', bold = true })
    vim.api.nvim_set_hl(0, 'MiniStatuslineModeOther', { fg = colors.cyan, bg = 'none', bold = true })
end

return {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
        ColorsSetup()
    end,
}
