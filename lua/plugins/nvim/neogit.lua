return
{
	{
		"TimUntersberger/neogit", dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require('neogit').setup({
				autoRefresh = true,
				integrations = { diffview = true, telescope = true },
				kind = 'tab',
				signs =
				{
					section = { "", "" },
					item = { "●", "○" },
				},
			})
		end
	}
}
