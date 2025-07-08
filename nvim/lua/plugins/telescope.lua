return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- fuzzy finding
			local builtin = require("telescope.builtin")
			-- in normal mode, when ctrl p, run find_files
			vim.keymap.set("n", "<C-p>", function()
				require("telescope.builtin").find_files({
					hidden = true,
					no_ignore = true, -- show dotfiles even if ignored
					file_ignore_patterns = { "node_modules", "__pycache__", ".venv", ".git", ".mypy_cache" },
				})
			end, {})
			vim.keymap.set("n", "<leader>fg", function()
				require("telescope.builtin").live_grep({
					file_ignore_patterns = { "node_modules", "__pycache__", ".venv", ".git", ".mypy_cache" },
				})
			end, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),

						-- pseudo code / specification for writing custom displays, like the one
						-- for "codeactions"
						-- specific_opts = {
						--   [kind] = {
						--     make_indexed = function(items) -> indexed_items, width,
						--     make_displayer = function(widths) -> displayer
						--     make_display = function(displayer) -> function(e)
						--     make_ordinal = function(e) -> string
						--   },
						--   -- for example to disable the custom builtin "codeactions" display
						--      do the following
						--   codeactions = false,
						-- }
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
