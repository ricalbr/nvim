return {
  {
    'kevinhwang91/nvim-bqf',
    enabled = false,
    event = 'BufEnter',
    config = function()
      require('bqf').setup()
    end,
  },
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
}
