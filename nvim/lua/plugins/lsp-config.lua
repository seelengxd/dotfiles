return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "pyright" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					-- your existing on_attach logic
				end,
			})
			require("lspconfig").ruff.setup({
				root_dir = require("lspconfig.util").root_pattern("pyproject.toml", "ruff.toml", ".git"),
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						venvPath = ".",
						venv = ".venv",
						analysis = {
							typeCheckingMode = "basic",
							diagnosticMode = "workspace",
							autoImportCompletions = true,
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticSeverityOverrides = {
								["reportUnusedImport"] = "none",
								["reportUnusedVariable"] = "none",
								-- add other overrides if needed
							},
						},
					},
				},
				handlers = {
					["textDocument/publishDiagnostics"] = function() end,
				},
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic in float" })

			local diagnostics_virtual_text = false

			function ToggleDiagnosticsVirtualText()
				diagnostics_virtual_text = not diagnostics_virtual_text
				vim.diagnostic.config({
					virtual_text = diagnostics_virtual_text,
				})
			end

			ToggleDiagnosticsVirtualText()

			vim.keymap.set(
				"n",
				"<leader>dv",
				ToggleDiagnosticsVirtualText,
				{ desc = "Toggle diagnostics virtual text" }
			)

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				pattern = "*.py",
				callback = function()
					local clients = vim.lsp.get_active_clients({ bufnr = 0 })
					for _, client in ipairs(clients) do
						if client.supports_method("textDocument/formatting") then
							vim.lsp.buf.format({ bufnr = 0 })
							break
						end
					end
				end,
			})
		end,
	},
}
