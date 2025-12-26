-- File Saved
vim.api.nvim_create_autocmd('BufWritePost',{
	callback = function ()
		vim.notify("File Saved: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
	end
})
vim.api.nvim_create_autocmd('CursorHold', {
	callback = function ()
		vim.diagnostic.open_float(nil, { focus = false })
	end
})
 vim.opt.updatetime = 500 --delay in ms
