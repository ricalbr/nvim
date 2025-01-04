-- local treesitter = require "nvim-treesitter"

local M = {}

M.setup = function()
  local group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true })

  require('nvim-treesitter').setup {
    ensure_installed = { 'c', 'cpp', 'lua', 'python', 'vimdoc', 'latex', 'vim', 'bash' },
  }
end

-- M.setup()

return M
