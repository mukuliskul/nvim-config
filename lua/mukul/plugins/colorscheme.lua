return {
	-- Kanagawa for dark mode
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
	},
	-- Rosé Pine for light mode
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			-- 1. Detect light/dark mode
			local function detect_system_mode()
				if vim.fn.has("mac") == 1 then
					local ok, result = pcall(vim.fn.system, "defaults read -g AppleInterfaceStyle")
					if ok and result:match("Dark") then
						return "dark"
					end
					return "light"
				else
					-- fallback: assume dark
					return "dark"
				end
			end

			local mode = detect_system_mode()
			vim.o.background = mode

			-- 2. Setup Kanagawa
			require("kanagawa").setup({
				background = {
					dark = "wave",
					light = "lotus",
				},
			})

			-- 3. Setup Rosé Pine
			require("rose-pine").setup({
				variant = "dawn", -- dawn is the light theme (also: main, moon for dark)
				-- You can customize more options here if needed
			})

			-- 4. Apply the colorscheme based on system mode
			if mode == "dark" then
				vim.cmd("colorscheme kanagawa")
			else
				vim.cmd("colorscheme rose-pine")
			end
		end,
	},
}
