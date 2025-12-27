-- File Saved notify
vim.api.nvim_create_autocmd('BufWritePost',{
	callback = function ()
		vim.notify("Saved :" .. vim.fn.expand("%:t"), vim.log.levels.INFO)
	end
})

-- open float diagnostic on hover 
vim.api.nvim_create_autocmd('CursorHold', {
	callback = function ()
		vim.diagnostic.open_float(nil, { focus = false })
	end
})
 vim.opt.updatetime = 1000 --delay in ms
