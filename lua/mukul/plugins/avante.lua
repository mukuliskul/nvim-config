return {
	"yetone/avante.nvim",
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		instructions_file = "avante.md",
		provider = "copilot",
		providers = {
			copilot = {
				model = "gpt-4.1",
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		-- optional extras
		"nvim-mini/mini.pick",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
		"ibhagwan/fzf-lua",
		"stevearc/dressing.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",

		-- GitHub Copilot
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({
					suggestion = { enabled = true, auto_trigger = true },
					panel = { enabled = true },
					copilot_model = "gpt-4.1",
				})
				
				-- Configure copilot LSP client to use UTF-8 encoding
				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(args)
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						if client and client.name == "copilot" then
							client.offset_encoding = "utf-8"
						end
					end,
				})
			end,
		},

		-- optional extras for images & markdown rendering
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
					use_absolute_path = true,
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = { file_types = { "Avante" } },
			ft = { "markdown" },
		},
	},
}
