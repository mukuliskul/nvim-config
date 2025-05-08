return {
	"williamboman/mason.nvim",
	event = { "BufEnter" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local lspconfig = require("lspconfig")

		local capabilities = cmp_nvim_lsp.default_capabilities()

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"ts_ls",
				"lua_ls",
				"pyright",
				"html",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				"yamlls",
				"marksman",
			},
			automatic_enable = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"ruff",
				"sonarlint-language-server",
			},
		})

		-- Optional manual configuration overrides
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		lspconfig["pyright"].setup({
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace",
					},
				},
			},
		})

		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
			},
		})
	end,
}
