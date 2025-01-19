return {
  {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.3', -- last version compatible with Nvim 0.9
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'BufReadPre' },
    },
    build = ':TSUpdate',
    branch = 'main',
    -- lazy = false,
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'cpp', 'latex', 'lua', 'markdown', 'markdown_inline', 'python', 'query', 'vim', 'vimdoc' },
        highlight = {
          disable = function(lang, buf)
            local max_filesize = 5 * 1024 * 1024 -- 5 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
      }
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.wo.foldtext = 'v:lua.vim.treesitter.foldtext()'
    end,
  },
}
