-- Require the icons module
local devicons = require('nvim-web-devicons')

--------------------------------------------------------------------------------------------------------------
-- Notify when file is Saved
vim.api.nvim_create_autocmd('BufWritePost', {
	callback = function()
		local filename = vim.fn.expand("%:t")
		local filetype = vim.fn.expand("%:e")  -- Get the file extension
		local num_lines = vim.fn.line('$')  -- Get the number of lines
		local file_size = vim.fn.getfsize(vim.fn.expand("%"))  -- Get the file size in bytes
		-- Get the icon for the filetype
		local icon, _ = devicons.get_icon(filename, filetype)
		-- Format the message
		local message = string.format(" %s Saved %s| Lines: %d| Size: %dbytes", icon or '', filename, num_lines, file_size)
		vim.notify(message, vim.log.levels.INFO)
	end
})
--------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
-- Auto commands for macro recording notifications
vim.api.nvim_create_autocmd('RecordingEnter', {
    callback = function()
        vim.notify("[●] Recording Macro to Register: " .. vim.fn.reg_recording(), vim.log.levels.INFO)
    end
})
vim.api.nvim_create_autocmd('RecordingLeave', {
    callback = function()
        vim.notify("[✓] Recorded Macro to Register: " .. vim.fn.reg_recording(), vim.log.levels.INFO)
    end
})
--------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
-- open float diagnostic on hover 
vim.api.nvim_create_autocmd('CursorHold', {
	callback = function ()
		vim.diagnostic.open_float(nil, { focus = false })
	end
})
--------------------------------------------------------------------------------------------------------------

 vim.opt.updatetime = 1000 --delay in ms
