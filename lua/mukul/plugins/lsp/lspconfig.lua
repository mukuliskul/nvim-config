return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

				-- Enable inlay hints if supported
				if vim.lsp.inlay_hint then
					vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
				end
			end,
		})

		-- Configure LSP completion capabilities (optional)
		-- local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Configure diagnostics using vim.diagnostic.config
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●", -- Prefix for inline diagnostics, like a dot or other symbol
				source = true, -- Show the source of the diagnostic (true to show it)
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "❌",
					[vim.diagnostic.severity.WARN] = "⚠️",
					[vim.diagnostic.severity.HINT] = "💡",
					[vim.diagnostic.severity.INFO] = "ℹ️",
				},
			},
			underline = true, -- Underline the text with diagnostics
			update_in_insert = false, -- Disable updates in insert mode
			severity_sort = true, -- Sort diagnostics by severity (error > warning > info > hint)
		})
	end,
}
