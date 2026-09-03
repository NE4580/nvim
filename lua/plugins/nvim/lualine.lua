return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		priority = 1000,
		config = function()
			-- Custom mode colors/icons

			--------- bubbles_theme ------
			-- stylua: ignore
			local colors = {
				blue   = '#80a0ff',
				cyan   = '#79dac8',
				black  = '#080808',
				white  = '#c6c6c6',
				red    = '#ff5189',
				violet = '#d184e8',
				grey   = '#303030',
			}

			local bubbles_theme = {
				normal = {
					a = { fg = colors.black, bg = colors.violet },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.white },
				},

				insert = { a = { fg = colors.black, bg = colors.blue } },
				visual = { a = { fg = colors.black, bg = colors.cyan } },
				replace = { a = { fg = colors.black, bg = colors.red } },

				inactive = {
					a = { fg = colors.white, bg = colors.black },
					b = { fg = colors.white, bg = colors.black },
					c = { fg = colors.white },
				},
			}
			require("lualine").setup({
				options = {
					theme = bubbles_theme,
					component_separators = "",
					section_separators = { left = "", right = "" },
					disabled_filetypes = { statusline = { "dashboard", "alpha", "NvimTree" } },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								local icons = {
									["NORMAL"] = "○ ",
									["INSERT"] = " ",
									["VISUAL"] = "󰒉 ",
									["V-LINE"] = "󰒉  ",
									["V-BLOCK"] = "󰒉 ",
									["COMMAND"] = "󰘳 ",
									["REPLACE"] = "󰉵 ",
									["SELECT"] = "󰩫 ",
									["TERMINAL"] = " ",
								}
								return icons[str] .. str:sub(1, 1):upper() .. str:sub(2):lower()
							end,
						},
					},
					lualine_b = {
						"filename",
						"diagnostics",
						"branch",
						{
							"diff",
							--	symbols = { added = " ", modified = " ", removed = " " },
						},
					},
					lualine_c = {},
					lualine_x = { "lsp_status" },
					lualine_y = { "filetype", "filesize", "progress", "fileformat" },
					lualine_z = {
						{ "location", separator = { right = "" }, left_padding = 2 },
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = { "filetype" },
					lualine_z = { "fileformat" },
				},
			})
			----------------------------------
		end,
	},
}
