-- none-ls config


local M = {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    }
}
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

function M.config()
    local null_ls = require "null-ls"

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup {
        debug = false,
        sources = {
            formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
            formatting.black.with({ extra_args = { "--fast", "--skip-string-normalization", "--line-length=120" } }),
            formatting.isort,
            diagnostics.flake8.with({ extra_args = { "--max-line-length=120" } }),
            formatting.stylua,
            formatting.clang_format,
            diagnostics.clang_check,
            null_ls.builtins.completion.spell,
        },
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
					-- vim.lsp.buf.formatting_sync() -- DEPRECATED
				end,
			})
		end
	end
    }
end

return M
