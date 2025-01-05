return {
  {
    'kevinhwang91/nvim-bqf',
    event = 'BufEnter',
    config = function()
      require('bqf').setup()
    end,
  },
  {
    'stevearc/quicker.nvim',
    enabled = false,
    event = 'FileType qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
}
