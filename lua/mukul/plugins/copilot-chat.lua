return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			completeopt = "popup",
		},
		keys = {
			{ "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
			{ "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
			{ "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
			{ "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix code" },
			{ "<leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize code" },
			{ "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Add documentation" },
			{ "<leader>am", "<cmd>CopilotChatCommit<cr>", desc = "Generate commit message" },
			{ "<leader>ap", "<cmd>CopilotChatPrompts<cr>", desc = "Select prompt" },
			{ "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "Toggle chat" },
			{ "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "Reset chat" },
			{
				"<leader>ai",
				function()
					local input = vim.fn.input("Ask Copilot: ")
					if input ~= "" then
						vim.cmd("CopilotChat " .. input)
					end
				end,
				desc = "Ask input",
			},
			{
				"<leader>aq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, {
							selection = require("CopilotChat.select").buffer,
						})
					end
				end,
				desc = "Quick chat",
			},
		},
	},
}
