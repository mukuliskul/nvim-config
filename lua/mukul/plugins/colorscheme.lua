return {
	"rebelot/kanagawa.nvim",
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

		-- 2. Setup kanagawa theme settings
		require("kanagawa").setup({
			background = {
				dark = "wave",
				light = "lotus",
			},
			-- you can add other options here
		})

		-- 3. Apply the colourscheme
		vim.cmd("colorscheme kanagawa")
	end,
}
