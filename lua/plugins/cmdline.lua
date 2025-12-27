return {
	{ 'folke/noice.nvim', event = 'VeryLazy',
		opts = { lsp = { progress = { enabled = true }, },
			messages = {
				enabled = true,
				view = "notify",
				format = "default",
			},
		},
		dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify', },
	}
}

