return{
	{ "preservim/tagbar",cmd = "TagbarToggle",
		init = function()
			vim.g.tagbar_position = 'right'
			vim.g.tagbar_width = 25
			vim.g.tagbar_autofocus = 1
			vim.g.tagbar_autosort = 0
			vim.g.tagbar_autoshowtag = 1
			vim.g.tagbar_iconchars = {"", ""}
			vim.g.tagbar_show_visibility = 1
			vim.g.tagbar_autoclose = 1
			vim.g.tagbar_close_on_q = 1
			vim.g.tagbar_show_tag_prototype = 1
		end
	}
}
