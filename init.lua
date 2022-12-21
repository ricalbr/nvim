-- init.lua
-- @ricalbr

-- plugins {{{
-- install packer automatically
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	vim.cmd([[packadd packer.nvim]])
end

local function get_config(name)
	return string.format('require("lua/config/%s")', name)
end

-- install plugins
require("packer").startup(function(use)
	-- base plugins
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("lewis6991/impatient.nvim") -- optimize packer with caching
	use({
		"nathom/filetype.nvim",
		config = function()
			require("filetype").setup({
				overrides = { extensions = { pgm = "gcode", gcode = "gcode", g = "gcode", ngc = "gcode" } },
			})
		end,
	})

	-- colorschemes and icons
	use("rose-pine/neovim")
	use("navarasu/onedark.nvim")
	use("ricalbr/vim-colors")

	use({ -- lsp
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"glepnir/lspsaga.nvim",
			"j-hui/fidget.nvim", -- Useful status updates for LSP
		},
	})

	use({ -- for formatters and linters
		"jose-elias-alvarez/null-ls.nvim",
		config = get_config("null-ls"),
	})

	use({ -- autocompletion and snippets
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	})

	use({ -- treesitter
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		config = get_config("treesitter"),
	})
	use({ -- additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = { "nvim-lua/plenary.nvim" },
		config = get_config("telescope"),
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })
	use("nvim-telescope/telescope-frecency.nvim")
	use("kkharji/sqlite.lua")
	use("BurntSushi/ripgrep") -- grepper (suggested dependency)

	-- other lua plugins
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair in the same line
				ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
				check_ts = true, -- use treesitter to check for a pair.
			})
		end,
	})
	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons", "kaicataldo/material.vim" },
		opt = true,
		cmd = "NvimTreeToggle",
		config = get_config("nvim-tree"),
	})
	use("nvim-lualine/lualine.nvim")

	use({
		"lewis6991/gitsigns.nvim",
		config = get_config("gitsigns"),
	})

	use("anuvyklack/pretty-fold.nvim")
	use({
		"echasnovski/mini.jump",
		branch = "stable",
		config = function()
			require("mini.jump").setup()
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use("tpope/vim-repeat")
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	})
	use("dstein64/vim-startuptime")

	-- set up your configuration after cloning packer.nvim
	if is_bootstrap then
		require("packer").sync()
	end
end)

if is_bootstrap then
	print("Plugins are being installed ...")
	return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})
local builtins = {
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"matchit",
	"matchparen",
	"logiPat",
	"rrhelper",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
	vim.g["loaded_" .. plugin] = 1
end
require("impatient") -- improve plugin performances
-- }}}

-- basic options {{{
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cindent = true
vim.opt.cinoptions = ":.5s,>1s,p0,t0,(0,g2"
vim.opt.cinwords = "if,else,while,do,for,switch,case,class,try"

vim.opt.path = ".,**"
vim.opt.undofile = true
vim.g.noswapfile = true

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.signcolumn = "yes"
vim.opt.scrolljump = 5
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 5
vim.g.noshowmode = true
vim.opt.lazyredraw = true
vim.opt.redrawtime = 100
vim.opt.synmaxcol = 0

-- listchars options
vim.opt.list = true
vim.opt.listchars = {
	nbsp = "·",
	extends = "›",
	precedes = "‹",
	tab = "  ",
	trail = "·",
}

-- fillchar options
vim.opt.fillchars = {
	diff = "∙",
	eob = " ",
	fold = "·",
	vert = "┃",
}

vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.diffopt:append({ "foldcolumn:0", "vertical" })
vim.g.splitvertical = true
vim.g.splitright = true
vim.g.splitbelow = true

-- folding options
vim.opt.foldlevelstart = 99
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- pretty-fold setup{{{
require("pretty-fold").setup({
	sections = {
		left = { "content" },
		right = {
			" ",
			"number_of_folded_lines",
			" ",
			function(config)
				return config.fill_char:rep(3)
			end,
		},
	},
	fill_char = "·",
	remove_fold_markers = true,
	keep_indentation = true,
	process_comment_signs = "spaces",
	comment_signs = {},
	stop_words = {
		"@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
	},
	add_close_pattern = true, -- true, 'last_line' or false
	matchup_patterns = {
		{ "{", "}" },
		{ "%(", ")" }, -- % to escape lua pattern char
		{ "%[", "]" }, -- % to escape lua pattern char
	},
	ft_ignore = { "neorg" },
}) -- }}}

vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({
	"*.bak",
	"*.swp",
	"*.swo",
	"*.a",
	"*.o",
	"*.so",
	"*.pyc",
	"*.class",
	"*.jpg",
	"*.jpeg",
	"*.gif",
	"*.png",
	"*.pdf",
	"*/.git*",
	"*.tar",
	"*.zip",
	"*.obj",
	"*.exe",
	"*.py[co]",
	".svn",
})
vim.opt.completeopt = "longest,menuone"
vim.opt.omnifunc = "syntaxcomplete#Complete"
-- }}}

-- autocommands {{{
-- remove all trailing whitespace on save
local api = vim.api
local TrimWhiteSpaceGrp = api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
	command = [[:%s/\s\+$//e]],
	group = TrimWhiteSpaceGrp,
})

-- highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank()",
	group = yankGrp,
})

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
	"BufReadPost",
	{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- enable spell checking for certain file types
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.txt", "*.md", "*.tex" },
	callback = function()
		vim.opt.spell = true
		vim.opt.spelllang = "en,it"
	end,
})
-- }}}

-- colorscheme {{{
vim.opt.termguicolors = true
require("rose-pine").setup({
	dark_variant = "moon",
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = false,
	disable_float_background = false,
	disable_italics = false,

	highlight_groups = {
		ColorColumn = { bg = "rose" },
		Normal = { bg = "none" },
		SignColumn = { bg = "none" },
		GitSignsAdd = { fg = "#68d98a" },
		GitSignsChange = { fg = "gold" },
		GitSignsDelete = { fg = "love" },
	},
})
vim.cmd([[colorscheme rose-pine]])

require("lualine").setup({
	options = {
		theme = "rose-pine",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		globalstatus = true,
	},
	sections = {
		lualine_b = { "filename" },
		lualine_c = { "" },
		lualine_y = { "branch", "diff", "diagnostics" },
	},
	inactive_sections = {
		lualine_b = { "filename" },
		lualine_c = { "" },
	},
})
-- }}}

-- key bindings {{{
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local function map(m, k, v, o)
	vim.keymap.set(m, k, v, o)
end

-- overload q and w command
vim.api.nvim_command("command! Q q")
vim.api.nvim_command("command! W w")
vim.api.nvim_command("command! Wq wq")

-- write file with sudo
vim.cmd.cnoreabbrev({ "w!!", "w !sudo tee > /dev/null %<CR>" })

-- set leader key
vim.g.mapleader = " "

-- juggling with files w/ telescope
vim.keymap.set(
	"n",
	"<leader>ff",
	':lua require"telescope.builtin".find_files(require("telescope.themes").get_dropdown({ previewer = false }))<CR>',
	opts
)
vim.keymap.set(
	"n",
	"<leader>fg",
	':lua require"telescope.builtin".live_grep(require("telescope.themes").get_dropdown({ previewer = false }))<CR>',
	opts
)
vim.keymap.set(
	"n",
	"<leader>fb",
	':lua require"telescope.builtin".buffers(require("telescope.themes").get_dropdown({ previewer = false }))<CR>',
	opts
)
vim.keymap.set(
	"n",
	"<leader>fh",
	':lua require"telescope.builtin".help_tags(require("telescope.themes").get_dropdown({ previewer = false }))<CR>',
	opts
)

map("n", "\\", ":bd<CR>", opts)
map("n", "<leader>nt", ":tabnew<CR>", opts)
map("n", "<leader>dt", ":tabclose<CR>", opts)
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)
map("n", "<Leader>re", ":retab<CR>", opts)

-- mapping C-s to save the file, in all the modes
map("n", "<C-s>", "<Esc>:Update<CR>", opts)
map("v", "<C-s>", "<Esc>:Update<CR>gv", opts)
map("i", "<C-s>", "<Esc>:Update<CR>", opts)

-- join lines keepin the cursor position
map("n", "J", ':let p=getpos(".")<bar>join<bar>call setpos(".", p)<CR>', opts)

-- move vertically by visual line (don't skip wrapped lines)
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- retain visual selection after `>` or `<`
map("v", ">", ">gv", opts)
map("v", "<", "<gv", opts)

-- argslist navigation
map("n", "[a", ":previous<CR>", opts)
map("n", "]a", ":next<CR>", opts)
map("n", "[A", ":first<CR>", opts)
map("n", "]A", ":last<CR>", opts)

-- quickfix list navigation
map("n", "[q", ":cp<CR>", opts)
map("n", "]q", ":cn<CR>", opts)

-- switch between splits using ctrl + {h,j,k,l}
map("i", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("i", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("i", "<C-k>", "<C-\\><C-N><C-w>k", opts)
map("i", "<C-l>", "<C-\\><C-N><C-w>l", opts)

map("n", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("n", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("n", "<C-k>", "<C-\\><C-N><C-w>k", opts)
map("n", "<C-l>", "<C-\\><C-N><C-w>l", opts)

map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- window management
map("n", "<Leader>0", "<C-w>=", opts)
map("n", "<Leader>+", ":vertical resize +10<CR>", opts)
map("n", "<Leader>-", ":vertical resize -10<CR>", opts)

-- no K or arrow keys
map("n", "<K>", "<NOP>", opts)
map("n", "<Down>", "<NOP>", opts)
map("n", "<Up>", "<NOP>", opts)
map("n", "<Left>", "<NOP>", opts)
map("i", "<Right>", "<NOP>", opts)
map("i", "<Down>", "<NOP>", opts)
map("i", "<Up>", "<NOP>", opts)
map("i", "<Left>", "<NOP>", opts)
map("i", "<Right>", "<NOP>", opts)

-- nvim-tree
map("n", "<Leader>nn", ":NvimTreeToggle<CR>")
-- }}}

-- completion and lsp {{{
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- see `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		if vim.lsp.buf.format then
			vim.lsp.buf.format()
			vim.lsp.buf.formatting()
		end
	end, { desc = "Format current buffer with LSP" })
end

-- setup mason so it can manage external tooling
require("mason").setup()

-- enable the following language servers
local servers = { "clangd", "pyright", "tsserver", "sumneko_lua" }
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- turn on lsp status information
require("fidget").setup()

-- python
require("lspconfig").pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT", -- Tell the language server which version of Lua you're using (most likely LuaJIT)
				path = runtime_path, -- Setup your lua path
			},
			diagnostics = {
				globals = { "vim" },
			},
			-- workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
})

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})
-- require("lsp")
-- }}}
