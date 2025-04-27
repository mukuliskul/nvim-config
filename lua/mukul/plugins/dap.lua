return {
	-- Core dap
	{
		"mfussenegger/nvim-dap",
	},

	-- UI for dap
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},

	-- dap-python for Python
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv"
			local python_path

			if vim.fn.has("win32") == 1 then
				python_path = mason_path .. "/Scripts/python.exe"
			else
				python_path = mason_path .. "/bin/python"
			end

			require("dap-python").setup(python_path)

			require("dap").configurations.python = {
				{
					type = "python", -- Type of configuration
					request = "launch", -- We are launching a Python file
					name = "Launch file", -- Name for the config
					program = "${file}", -- The file to debug
					pythonPath = function()
						return vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python" -- Python interpreter path
					end,
				},
			}
			-- TODO: test this with neotest
			-- DAP Keybindings
			vim.keymap.set(
				"n",
				"<leader>dc",
				require("dap").continue,
				{ noremap = true, silent = true, desc = "Continue" }
			)
			vim.keymap.set("n", "<leader>dp", require("dap").pause, { noremap = true, silent = true, desc = "Pause" })
			vim.keymap.set(
				"n",
				"<leader>do",
				require("dap").step_over,
				{ noremap = true, silent = true, desc = "Step Over" }
			)
			vim.keymap.set(
				"n",
				"<leader>di",
				require("dap").step_into,
				{ noremap = true, silent = true, desc = "Step Into" }
			)
			vim.keymap.set(
				"n",
				"<leader>du",
				require("dap").step_out,
				{ noremap = true, silent = true, desc = "Step Out" }
			)
			vim.keymap.set(
				"n",
				"<leader>db",
				require("dap").toggle_breakpoint,
				{ noremap = true, silent = true, desc = "Toggle Breakpoint" }
			)
			vim.keymap.set("n", "<leader>dB", function()
				require("dap").set_breakpoint(vim.fn.input("Condition: "))
			end, { noremap = true, silent = true, desc = "Set Conditional Breakpoint" })
			vim.keymap.set(
				"n",
				"<leader>du",
				require("dapui").toggle,
				{ noremap = true, silent = true, desc = "Toggle DAP UI" }
			)
			vim.keymap.set(
				"n",
				"<leader>dv",
				require("dapui").eval,
				{ noremap = true, silent = true, desc = "Evaluate Expression" }
			)
			vim.keymap.set(
				"n",
				"<leader>dt",
				require("dap").terminate,
				{ noremap = true, silent = true, desc = "Terminate Debugger" }
			)
			vim.keymap.set(
				"n",
				"<leader>dc",
				require("dapui").close,
				{ noremap = true, silent = true, desc = "Close DAP UI" }
			)
		end,
	},
}
