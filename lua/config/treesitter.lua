require('nvim-treesitter.configs').setup {
  ensure_installed = { 'bash', 'c', 'cpp', 'latex', 'lua', 'markdown', 'markdown_inline', 'python', 'query', 'vim', 'vimdoc' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
