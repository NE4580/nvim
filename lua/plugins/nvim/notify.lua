return{
	{ 'rcarriga/nvim-notify',
	config = function()
		local notify = require('notify')
		notify.setup({
			level = vim.log.levels.TRACE, -- Show all levels

			stages = "fade_in_slide_out", -- Animation stage (fade, static, slide)
			timeout = 2000,  -- Notification duration in milliseconds
			max_width = 50,
			max_height = 10,
			border = "rounded",       -- Border style of notifications
			background_color = "#282c34",  -- Background color of notifications
		})
		vim.notify = notify
	end
}
}
