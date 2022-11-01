-- install packer automatically
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path, }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- install plugins
return packer.startup(function(use)
    -- base plugins
    use 'wbthomason/packer.nvim' -- Have packer manage itself
    use 'nvim-lua/popup.nvim' -- An implementation of the Popup API from vim in Neovim
    use 'nvim-lua/plenary.nvim' -- Useful lua functions used ny lots of plugins

    -- colorschemes and icons
    use 'kaicataldo/material.vim'
    use 'nvim-tree/nvim-web-devicons'
    use 'rose-pine/neovim'
    use 'ricalbr/vim-colors'

    -- cmp plugins
    use 'hrsh7th/nvim-cmp' -- The completion plugin
    use 'hrsh7th/cmp-buffer' -- buffer completions
    use 'hrsh7th/cmp-path' -- path completions
    use 'hrsh7th/cmp-cmdline' -- cmdline completions
    use 'saadparwaiz1/cmp_luasnip' -- snippet completions
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'

    -- snippets
    use 'L3MON4D3/LuaSnip' --snippet engine
    use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

    -- lsp
    use 'neovim/nvim-lspconfig' -- enable LSP
    use 'williamboman/mason.nvim' -- simple to use language server installer
    use 'williamboman/mason-lspconfig.nvim' -- simple to use language server installer
    use 'glepnir/lspsaga.nvim'

    -- telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-frecency.nvim'
    use 'kkharji/sqlite.lua'
    use 'BurntSushi/ripgrep' -- grepper (suggested dependency)
    use 'sharkdp/fd' -- finder (optional dependency)

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- other lua plugins
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-lualine/lualine.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'numToStr/Comment.nvim'
    use 'lewis6991/impatient.nvim'
    use 'anuvyklack/pretty-fold.nvim'

    use 'rhysd/clever-f.vim'
    use 'Raimondi/delimitMate'
    use 'romainl/vim-cool'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'

    -- set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end
)
