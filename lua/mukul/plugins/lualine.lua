return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-- Detect system appearance
		local function detect_system_mode()
			if vim.fn.has("mac") == 1 then
				local ok, result = pcall(vim.fn.system, "defaults read -g AppleInterfaceStyle")
				if ok and result:match("Dark") then
					return "dark"
				end
				return "light"
			else
				return "dark"
			end
		end

		local mode = detect_system_mode()

		-- Rosé Pine Dawn (light) colors
		local rose_pine_dawn_colors = {
			base = "#faf4ed",
			surface = "#fffaf3",
			overlay = "#f2e9e1",
			muted = "#9893a5",
			subtle = "#797593",
			text = "#575279",
			love = "#b4637a",
			gold = "#ea9d34",
			rose = "#d7827e",
			pine = "#286983",
			foam = "#56949f",
			iris = "#907aa9",
			highlight_low = "#f4ede8",
			highlight_med = "#dfdad9",
			highlight_high = "#cecacd",
		}

		-- Kanagawa (dark) colors
		local kanagawa_colors = {
			base = "#1F1F28",
			surface0 = "#2A2A37",
			surface1 = "#363646",
			surface2 = "#54546D",
			text = "#DCD7BA",
			subtext1 = "#C8C093",
			blue = "#7E9CD8",
			green = "#76946A",
			violet = "#957FB8",
			yellow = "#E6C384",
			red = "#E82424",
			peach = "#FFA066",
			crust = "#16161D",
		}

		-- Select colors based on mode
		local colors = mode == "dark" and kanagawa_colors or rose_pine_dawn_colors

		-- Create theme based on selected colors
		local my_lualine_theme
		
		if mode == "dark" then
			-- Kanagawa theme
			my_lualine_theme = {
				normal = {
					a = { bg = colors.blue, fg = colors.base, gui = "bold" },
					b = { bg = colors.surface0, fg = colors.text },
					c = { bg = colors.base, fg = colors.subtext1 },
				},
				insert = {
					a = { bg = colors.green, fg = colors.base, gui = "bold" },
					b = { bg = colors.surface0, fg = colors.text },
					c = { bg = colors.base, fg = colors.subtext1 },
				},
				visual = {
					a = { bg = colors.violet, fg = colors.base, gui = "bold" },
					b = { bg = colors.surface0, fg = colors.text },
					c = { bg = colors.base, fg = colors.subtext1 },
				},
				command = {
					a = { bg = colors.peach, fg = colors.base, gui = "bold" },
					b = { bg = colors.surface0, fg = colors.text },
					c = { bg = colors.base, fg = colors.subtext1 },
				},
				replace = {
					a = { bg = colors.red, fg = colors.base, gui = "bold" },
					b = { bg = colors.surface0, fg = colors.text },
					c = { bg = colors.base, fg = colors.subtext1 },
				},
				inactive = {
					a = { bg = colors.surface1, fg = colors.subtext1, gui = "bold" },
					b = { bg = colors.surface1, fg = colors.subtext1 },
					c = { bg = colors.surface0, fg = colors.subtext1 },
				},
			}
		else
			-- Rosé Pine Dawn theme
			my_lualine_theme = {
				normal = {
					a = { bg = colors.pine, fg = colors.base, gui = "bold" },
					b = { bg = colors.overlay, fg = colors.text },
					c = { bg = colors.surface, fg = colors.subtle },
				},
				insert = {
					a = { bg = colors.foam, fg = colors.base, gui = "bold" },
					b = { bg = colors.overlay, fg = colors.text },
					c = { bg = colors.surface, fg = colors.subtle },
				},
				visual = {
					a = { bg = colors.iris, fg = colors.base, gui = "bold" },
					b = { bg = colors.overlay, fg = colors.text },
					c = { bg = colors.surface, fg = colors.subtle },
				},
				command = {
					a = { bg = colors.gold, fg = colors.base, gui = "bold" },
					b = { bg = colors.overlay, fg = colors.text },
					c = { bg = colors.surface, fg = colors.subtle },
				},
				replace = {
					a = { bg = colors.love, fg = colors.base, gui = "bold" },
					b = { bg = colors.overlay, fg = colors.text },
					c = { bg = colors.surface, fg = colors.subtle },
				},
				inactive = {
					a = { bg = colors.highlight_med, fg = colors.muted, gui = "bold" },
					b = { bg = colors.highlight_med, fg = colors.muted },
					c = { bg = colors.highlight_low, fg = colors.muted },
				},
			}
		end

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
						color = { fg = mode == "dark" and "#FFA066" or "#ea9d34" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
