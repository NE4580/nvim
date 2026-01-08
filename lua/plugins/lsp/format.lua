return
{
	{
		"stevearc/conform.nvim", event = 'VeryLazy', -- load before saveing
		cmd = 'ConformInfo',
		keys =
		{
			{
				"<leader>bc", function ()
					require('conform').format({ async = true, lsp_fallback = true })
				end,
				mode = { 'n', 'v'}, desc = 'Conform Format Code/Selection',
			},
	},
		opts = {
			formatters_by_ft =
			{
				cpp = { "clang-format" },
				c = { "clang-format" },
			},
			format_on_save =
			{
				timeout = 500,
				lsp_fallback = true,
			},
		},
	}
}
