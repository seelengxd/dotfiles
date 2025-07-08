return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false, -- neo-tree will lazily load itself
	---@module "neo-tree"
	---@diagnostic disable-next-line: undefined-doc-name
	---@type neotree.Config?
	opts = {
		-- fill any relevant options here
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,

				hide_by_name = {},
				never_show = {},
			},
		},
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,

					hide_by_name = {},
					never_show = {},
				},
			},
			default_component_configs = {
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
			},
		})

		vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left<CR>")
	end,
}
