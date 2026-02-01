return {
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-;>]],
				shade_filetypes = {},
				shade_terminals = true,
				start_in_insert = true,
				persist_size = true,
				direction = "float", --horizontal/vertical
				float_opts = {
					border = "rounded", --double
					winblend = 1,
					width = 75,
					size = 32,
				},
			})
		end,
	},
}
