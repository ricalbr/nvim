-- telescope config

local telescope = require("telescope")
telescope.setup({
	defaults = {
		path_display = { "smart" },
		mappings = {
			i = {
				["?"] = require("telescope.actions.layout").toggle_preview, -- preview is disabled by default
			},
		},
	},
})

-- keymaps
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
-- juggling with files w/ telescope
-- vim.keymap.set( "n", "<leader>ff", ':lua require"telescope.builtin".find_files(require("telescope.themes").get_dropdown({ previewer = false }))<CR>', opts)
-- vim.keymap.set( "n", "<leader>fg", ':lua require"telescope.builtin".live_grep(require("telescope.themes").get_dropdown({ previewer = false }))<CR>', opts)
-- vim.keymap.set( "n", "<leader>fb", ':lua require"telescope.builtin".buffers(require("telescope.themes").get_dropdown({ previewer = false }))<CR>', opts)
-- vim.keymap.set( "n", "<leader>fh", ':lua require"telescope.builtin".help_tags(require("telescope.themes").get_dropdown({ previewer = false }))<CR>', opts)

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "frecency")
