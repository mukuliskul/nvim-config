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

		-- Kanagawa colors
		local kanagawa_colors = {
			blue = "#5B82AA",
			green = "#76946A",
			violet = "#938AA9",
			yellow = "#DCD7BA",
			red = "#C34043",
			fg = "#DCD7BA",
			bg = "#1F1F28",
			inactive_bg = "#16161D",
			surface0 = "#2A2A37",
			surface1 = "#363646",
			surface2 = "#54546D",
			crust = "#11111B",
		}

		local colors = kanagawa_colors

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.crust, gui = "bold" },
				b = { bg = colors.surface0, fg = colors.text },
				c = { bg = colors.base, fg = colors.subtext1 },
			},
			insert = {
				a = { bg = colors.green, fg = colors.crust, gui = "bold" },
				b = { bg = colors.surface0, fg = colors.text },
				c = { bg = colors.base, fg = colors.subtext1 },
			},
			visual = {
				a = { bg = colors.mauve, fg = colors.crust, gui = "bold" },
				b = { bg = colors.surface0, fg = colors.text },
				c = { bg = colors.base, fg = colors.subtext1 },
			},
			command = {
				a = { bg = colors.peach, fg = colors.crust, gui = "bold" },
				b = { bg = colors.surface0, fg = colors.text },
				c = { bg = colors.base, fg = colors.subtext1 },
			},
			replace = {
				a = { bg = colors.red, fg = colors.crust, gui = "bold" },
				b = { bg = colors.surface0, fg = colors.text },
				c = { bg = colors.base, fg = colors.subtext1 },
			},
			inactive = {
				a = { bg = colors.surface1, fg = colors.subtext1, gui = "bold" },
				b = { bg = colors.surface1, fg = colors.subtext1 },
				c = { bg = colors.surface0, fg = colors.subtext1 },
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
