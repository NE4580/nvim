return {
	{ "TimUntersberger/neogit", dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require('neogit').setup({
			autoRefresh = true,
			kind = "floating",
			integrations = {
				diffview = true,
				telescope = true,
			},
			signs = {
				section = { "▸", "▾" },
				item = { "●", "○" },
				ntracked = { "★", "☆" },
			},
		})
	end
}}
