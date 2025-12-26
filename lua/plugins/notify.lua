return{
	   { 'rcarriga/nvim-notify',
        config = function()
            require("notify").setup({
                -- Custom options can be set here
                timeout = 3000,  -- Notification duration in milliseconds
                stages = "fade", -- Animation stage (fade, static, slide)
                -- You can add more customization options
                max_width = 50,           -- Maximum width of notifications
                max_height = 10,          -- Maximum height of notifications
                border = "rounded",       -- Border style of notifications
                background_color = "#282c34",  -- Background color of notifications
                icons = {
                   -- ERROR = "",
                    WARN = "",
                    INFO = "",
                    DEBUG = "",
                    TRACE = "✏️",
                }
            })
        end
    }
}
