-- https://www.youtube.com/watch?v=_YaI2vDbk0o
return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	init = function()
		vim.g["test#strategy"] = "neovim"
		vim.g["test#neovim#term_position"] = "vert"
	end,
	vim.keymap.set("n", "<leader>t", ":TestNearest<CR>"),
	vim.keymap.set("n", "<leader>T", ":TestFile<CR>"),
	vim.keymap.set("n", "<leader>a", ":TestSuite<CR>"),
	vim.keymap.set("n", "<leader>l", ":TestLast<CR>"),
	vim.keymap.set("n", "<leader>g", ":TestVisit<CR>"),
}
