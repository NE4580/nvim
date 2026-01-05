return
{
	{
		'akinsho/toggleterm.nvim',
		config = function()
			require("toggleterm").setup
			{
				size = 20,
				open_mapping = [[<c-t>]],
				shade_filetypes = {},
				shade_terminals = true,
				start_in_insert = true,
				persist_size = true,
				direction = 'horizontal',
				float_opts =
				{
					border = "double",
					winblend = 1,
					width = 75,
					size = 32,
					title_pos = "left",
					title = "CMD: {}"
				},
			}
		end
	}
}
