return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local tokyonight_colors = {
			blue = "#65D1FF",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#112638",
			inactive_bg = "#2c3043",
		}

		local catppuccin_colors = {
			rosewater = "#f5e0dc",
			flamingo = "#f2cdcd",
			mauve = "#cba6f7",
			pink = "#f5c2e7",
			red = "#f38ba8",
			maroon = "#eba0ac",
			peach = "#fab387",
			yellow = "#f9e2af",
			green = "#a6e3a1",
			teal = "#94e2d5",
			sky = "#89dceb",
			sapphire = "#74c7ec",
			blue = "#89b4fa",
			lavender = "#b4befe",
			text = "#cdd6f4",
			subtext1 = "#bac2de",
			surface0 = "#313244",
			surface1 = "#45475a",
			surface2 = "#585b70",
			base = "#1e1e2e",
			mantle = "#181825",
			crust = "#11111b",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = catppuccin_colors.blue, fg = catppuccin_colors.crust, gui = "bold" },
				b = { bg = catppuccin_colors.surface0, fg = catppuccin_colors.text },
				c = { bg = catppuccin_colors.base, fg = catppuccin_colors.subtext1 },
			},
			insert = {
				a = { bg = catppuccin_colors.green, fg = catppuccin_colors.crust, gui = "bold" },
				b = { bg = catppuccin_colors.surface0, fg = catppuccin_colors.text },
				c = { bg = catppuccin_colors.base, fg = catppuccin_colors.subtext1 },
			},
			visual = {
				a = { bg = catppuccin_colors.mauve, fg = catppuccin_colors.crust, gui = "bold" },
				b = { bg = catppuccin_colors.surface0, fg = catppuccin_colors.text },
				c = { bg = catppuccin_colors.base, fg = catppuccin_colors.subtext1 },
			},
			command = {
				a = { bg = catppuccin_colors.peach, fg = catppuccin_colors.crust, gui = "bold" },
				b = { bg = catppuccin_colors.surface0, fg = catppuccin_colors.text },
				c = { bg = catppuccin_colors.base, fg = catppuccin_colors.subtext1 },
			},
			replace = {
				a = { bg = catppuccin_colors.red, fg = catppuccin_colors.crust, gui = "bold" },
				b = { bg = catppuccin_colors.surface0, fg = catppuccin_colors.text },
				c = { bg = catppuccin_colors.base, fg = catppuccin_colors.subtext1 },
			},
			inactive = {
				a = { bg = catppuccin_colors.surface1, fg = catppuccin_colors.subtext1, gui = "bold" },
				b = { bg = catppuccin_colors.surface1, fg = catppuccin_colors.subtext1 },
				c = { bg = catppuccin_colors.surface0, fg = catppuccin_colors.subtext1 },
			},
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = my_lualine_theme,
			},
			sections = {
				lualine_c = {
					{ "filename", path = 1 }, -- relative path
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
