return {
	-- Kanagawa for dark mode
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
	},
	-- GitHub theme for light mode
	{
		"projekt0n/github-nvim-theme",
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

			-- 3. Setup GitHub theme
			require("github-theme").setup({
				options = {
					transparent = false,
					styles = {
						comments = "italic",
						functions = "NONE",
						keywords = "bold",
					},
				},
			})

			-- 4. Apply the colorscheme based on system mode
			if mode == "dark" then
				vim.cmd("colorscheme kanagawa")
			else
				vim.cmd("colorscheme github_light")
			end
		end,
	},
}
