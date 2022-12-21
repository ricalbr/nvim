-- lua

-- basic settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.fileformat = "unix"
vim.opt.foldmethod = "marker"
vim.opt.foldlevel = 0

-- lua language server
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
