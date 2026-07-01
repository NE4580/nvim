return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		priority = 1000,
		config = function()
			-- -- Custom mode colors/icons
			-- local custom_theme = {
			-- 	normal = { a = { fg = "#ffffff", bg = "#0078d4" } },
			-- 	insert = { a = { fg = "#ffffff", bg = "#00a86b" } },
			-- 	visual = { a = { fg = "#ffffff", bg = "#9b59b6" } },
			-- 	replace = { a = { fg = "#ffffff", bg = "#e74c3c" } },
			-- 	command = { a = { fg = "#ffffff", bg = "#f39c12" } },
			-- }

			require("lualine").setup({
				options = {
					theme = "auto", -- or custom_theme for custom colors
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "NvimTree" } },
					-- Add component separators
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },

					-- Always show mode
					always_divide_middle = true,
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								return " " .. str:sub(1, 1):upper() .. str:sub(2)
							end,
						},
					},
					lualine_b = {
						"branch",
						{
							"diff",
							symbols = { added = " ", modified = " ", removed = " " },
						},
						{
							"diagnostics",
							-- symbols = { error = " ", warn = " ", info = " ", hint = " " },
						},
					},
					lualine_c = {
						{
							"filename",
							path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
							symbols = {
								modified = " ●",
								readonly = " ",
								unnamed = " [No Name]",
							},
						},
					},
					lualine_x = { "fileformat", { "filetype", icon_only = true } },
					lualine_y = { "progress" },
					lualine_z = { { "location", padding = { left = 1, right = 1 } } },
				},
				-- Inactive sections (for when window loses focus)
				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				-- Tabline (shown at top)
				tabline = {
					lualine_a = { { "buffers", show_filename_only = true } },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { { "tabs", tabs_color = { fg = "#ffffff" } } },
				},
				-- Extensions for specific plugins
				extensions = { "nvim-tree", "trouble", "lazy", "mason" },
			})
		end,
	},
}
