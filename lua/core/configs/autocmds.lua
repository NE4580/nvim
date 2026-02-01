-- Require the icons module
local devicons = require("nvim-web-devicons")

-- Set the foldmethod to 'expr' and use treesitter for folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- Use tree-sitter folding
vim.o.foldlevelstart = 99 -- Show all folds initially

-- Move current line up
vim.api.nvim_set_keymap("n", "<A-k>", ":m-2<CR>==", { noremap = true, silent = true })

-- Move current line down
vim.api.nvim_set_keymap("n", "<A-j>", ":m+1<CR>==", { noremap = true, silent = true })

-- Move selected lines up
vim.api.nvim_set_keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move selected lines down
vim.api.nvim_set_keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

--------------------------------------------------------------------------------------------------------------
-- Notify when file is Saved
vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		local filename = vim.fn.expand("%:t")
		local filetype = vim.fn.expand("%:e") -- Get the file extension
		local num_lines = vim.fn.line("$") -- Get the number of lines
		local file_size = vim.fn.getfsize(vim.fn.expand("%")) -- Get the file size in bytes
		-- Get the icon for the filetype
		local icon, _ = devicons.get_icon(filename, filetype)
		-- Format the message
		local message =
			string.format(" %s Saved %s| Lines: %d| Size: %dbytes", icon or "", filename, num_lines, file_size)
		vim.notify(message, vim.log.levels.INFO)
	end,
})
--------------------------------------------------------------------------------------------------------------
-- Auto commands for macro recording notifications
vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function()
		vim.notify("[●] Recording Macro to Register: " .. vim.fn.reg_recording(), vim.log.levels.INFO)
	end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		vim.notify("[✓] Recorded Macro to Register: " .. vim.fn.reg_recording(), vim.log.levels.INFO)
	end,
})
--------------------------------------------------------------------------------------------------------------
-- open float diagnostic on hover
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

--------------------------------------------------------------------------------------------------------------
---Disable LSP formating
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		if client.server_capabilities then
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end
	end,
})
--------------------------------------------------------------------------------------------------------------
-- Define the autocommand to automatically start OmniSharp when a C# file is opened
vim.cmd([[
  augroup OmniSharpAutoStart
    autocmd!
    autocmd FileType csharp lua Start_omnisharp()
  augroup END
]])

-- Function to start OmniSharp for C# files
function Start_omnisharp()
	local omnisharp_cmd = {
		"OmniSharp", -- Command to start OmniSharp
		"--languageserver", -- Run OmniSharp as a language server
		"--hostPID",
		tostring(vim.fn.getpid()), -- Pass the current Neovim process ID
	}

	-- Run OmniSharp as a background job
	vim.fn.jobstart(omnisharp_cmd, {
		on_exit = function(_, code)
			if code ~= 0 then
				print("OmniSharp failed to start!")
			end
		end,
	})
end
--------------------------------------------------------------------------------------------------------------
vim.opt.updatetime = 1000 --delay in ms
