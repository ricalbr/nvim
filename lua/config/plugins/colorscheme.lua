return {
  'rmehri01/onenord.nvim',
  priority = 1000, -- Theme should load before most other plugins
  config = function()
    local colors = require('onenord.colors').load()
    require('onenord').setup {
      disable = {
        background = true,
        float_background = true,
      },
      custom_highlights = {
        ['ColorColumn'] = { bg = '#000000' },
        ['GitSignsAdd'] = { fg = colors.green },
        ['GitSignsChange'] = { fg = colors.yellow },
        ['GitSignsChangedelete'] = { link = 'GitSignsDelete' },
        ['GitSignsTopdelete'] = { link = 'GitSignsDelete' },
        ['MatchParen'] = { bg = '#585858', fg = '#DFDF87' },
        ['Normal'] = { bg = '#000000' },
        ['SignColumn'] = { bg = '#000000' },
      },
    }
    vim.cmd.colorscheme 'onenord'
  end,
}
