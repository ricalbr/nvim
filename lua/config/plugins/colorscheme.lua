return {
  'gremble0/yellowbeans.nvim',
  priority = 1000, -- Theme should load before most other plugins
  config = function()
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitSignsDelete' })
    vim.api.nvim_create_augroup('UpdateGutter', { clear = true })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = 'UpdateGutter',
      pattern = '*',
      callback = function()
        vim.cmd 'highlight ColorColumn guibg=#000000'
        vim.cmd 'highlight GitSignsAdd guifg=#006900'
        vim.cmd 'highlight GitSignsChange guifg=#FFFF00'
        vim.cmd 'highlight GitSignsDelete guifg=#FF0000'
        vim.cmd 'highlight GitSignsChangedelete guifg=#FF0000'
        vim.cmd 'highlight GitSignsTopdelete guifg=#FF0000'
        vim.cmd 'highlight GitSignsTopdelete guifg=#FF0000'
        vim.cmd 'highlight MatchParen ctermbg=240 ctermfg=186 cterm=NONE guibg=#585858 guifg=#DFDF87 gui=NONE'
        vim.cmd 'highlight Normal ctermbg=black guibg=#000000'
        vim.cmd 'highlight SignColumn ctermbg=black guibg=#000000'
      end,
    })
    vim.cmd.colorscheme 'yellowbeans'
  end,
}
