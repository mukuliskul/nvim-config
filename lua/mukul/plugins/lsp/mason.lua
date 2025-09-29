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

		-- Capabilities for completion support
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Mason UI
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Mason LSP servers
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
			automatic_installation = true, -- Mason auto-enables servers
		})

		-- Extra tools (linters/formatters/etc.)
		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"ruff",
				"sonarlint-language-server",
			},
		})

		-- =======================
		-- LSP SERVER CONFIGS
		-- =======================

		-- Lua
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- Python (Pyright)
		vim.lsp.config("pyright", {
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
		vim.lsp.enable("pyright")

		-- Emmet
		vim.lsp.config("emmet_ls", {
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
		vim.lsp.enable("emmet_ls")
	end,
}
