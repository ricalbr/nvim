return {
  -- 'gremble0/yellowbeans.nvim',
  'rmehri01/onenord.nvim',
  priority = 1000, -- Theme should load before most other plugins
  config = function()
    require('onenord').setup {
      disable = {
        background = true,
        float_background = true,
      },
    }
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#000000' })
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#006900' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#FFFF00' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#FF0000' })
    vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { fg = '#FF0000' })
    vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { fg = '#FF0000' })
    vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#585858', fg = '#DFDF87' })
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#000000' })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#000000' })
    vim.cmd.colorscheme 'onenord'
  end,
}
