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

			-- Optional: Python debugging configuration
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
		end,
	},

	-- Optional: auto-install debugpy
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = true,
	},
}
