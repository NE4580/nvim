require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,

	custom_highlights = function(colors)
		return {
			-- Slight transparency illusion
			Normal = { bg = "#11111b" },
			NormalFloat = { bg = "#11111b" },

			-- Sidebar/sign column blending
			SignColumn = { bg = "#11111b" },
			EndOfBuffer = { bg = "#11111b" },

			-- Cursor line
			CursorLine = { bg = colors.surface0 },

			-- Floating borders
			FloatBorder = {
				bg = "#11111b",
				fg = colors.blue,
			},

			-- Completion menu
			Pmenu = { bg = "#181825" },

			-- Telescope
			TelescopeNormal = {
				bg = "#11111b",
			},

			TelescopeBorder = {
				bg = "#11111b",
				fg = colors.lavender,
			},
		}
	end,
})

vim.cmd([[colorscheme catppuccin-mocha]])
-- Extra safety for plugins overriding backgrounds
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
