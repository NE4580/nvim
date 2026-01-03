return {
	{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
	config = function ()
		require('diffview').setup({
			use_icons = true,
			icons = {
				folder_closed = "",
				folder_open = "",
				added = "",
				modified = "✎",
				removed = "",
			},
			layout = {
				default = {
					layout = "focus",
					height = 32,
					winbar = true,
				},
			},
			view = {
				default = {
					mappings = {
						['<C-c>'] = '<cmd>DiffviewClose<CR>',
						['<C-t>'] = '<cmd>DiffviewToggleFiles<CR>',
					},
				}, 
			},
			ignore_whitespace = true,
			commit_log_entry_format = {
				format = 'short',
			},
			file_finder = {
				enable = true,
				finder = 'fzf',
			},
		})
	end,
},
}
