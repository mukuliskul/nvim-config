return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-neotest/neotest-python",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python"),
			},
		})

		-- Key mappings for neotest commands
		local opts = { noremap = true, silent = true, desc = "Neotest Mappings" }

		vim.keymap.set("n", "<leader>tt", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, vim.tbl_extend("force", opts, { desc = "Run File (Neotest)" }))

		vim.keymap.set("n", "<leader>tT", function()
			require("neotest").run.run(vim.uv.cwd())
		end, vim.tbl_extend("force", opts, { desc = "Run All Test Files (Neotest)" }))

		vim.keymap.set("n", "<leader>tr", function()
			require("neotest").run.run()
		end, vim.tbl_extend("force", opts, { desc = "Run Nearest (Neotest)" }))

		vim.keymap.set("n", "<leader>tl", function()
			require("neotest").run.run_last()
		end, vim.tbl_extend("force", opts, { desc = "Run Last (Neotest)" }))

		vim.keymap.set("n", "<leader>ts", function()
			require("neotest").summary.toggle()
		end, vim.tbl_extend("force", opts, { desc = "Toggle Summary (Neotest)" }))

		vim.keymap.set("n", "<leader>to", function()
			require("neotest").output.open({ enter = true, auto_close = true })
		end, vim.tbl_extend("force", opts, { desc = "Show Output (Neotest)" }))

		vim.keymap.set("n", "<leader>tO", function()
			require("neotest").output_panel.toggle()
		end, vim.tbl_extend("force", opts, { desc = "Toggle Output Panel (Neotest)" }))

		vim.keymap.set("n", "<leader>tS", function()
			require("neotest").run.stop()
		end, vim.tbl_extend("force", opts, { desc = "Stop (Neotest)" }))

		vim.keymap.set("n", "<leader>tw", function()
			require("neotest").watch.toggle(vim.fn.expand("%"))
		end, vim.tbl_extend("force", opts, { desc = "Toggle Watch (Neotest)" }))
	end,
}
