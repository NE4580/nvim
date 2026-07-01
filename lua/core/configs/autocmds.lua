-- Require the icons module
local devicons = require("nvim-web-devicons")
--------------------------------------------------------------------------------------------------------------
-- Keymaps

-- Move current line up
vim.keymap.set("n", "<A-k>", ":m-2<CR>==", { noremap = true, silent = true })

-- Move current line down
vim.keymap.set("n", "<A-j>", ":m+1<CR>==", { noremap = true, silent = true })

-- Move selected lines up
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move selected lines down
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

--------------------------------------------------------------------------------------------------------------
-- Auto Command Groups

local save_group = vim.api.nvim_create_augroup("SaveNotifications", { clear = true })
local recording_group = vim.api.nvim_create_augroup("MacroRecording", { clear = true })
local diagnostic_group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
local lsp_group = vim.api.nvim_create_augroup("LspEvents", { clear = true })
local remember_folds_group = vim.api.nvim_create_augroup("RememberFolds", { clear = true })
local resize_group = vim.api.nvim_create_augroup("AutoResizeSplits", { clear = true })
local whitespace_group = vim.api.nvim_create_augroup("TrimTrailingWhitespace", { clear = true })
local mkdir_group = vim.api.nvim_create_augroup("AutoCreateDirectories", { clear = true })

--------------------------------------------------------------------------------------------------------------
-- Helper Functions

local function human_size(bytes)
	if bytes < 1024 then
		return bytes .. " B"
	elseif bytes < 1024 * 1024 then
		return string.format("%.1f KB", bytes / 1024)
	else
		return string.format("%.2f MB", bytes / (1024 * 1024))
	end
end

--------------------------------------------------------------------------------------------------------------
-- Notify when file is Saved

vim.api.nvim_create_autocmd("BufWritePost", {
	group = save_group,
	callback = function()
		local filename = vim.fn.expand("%:t")
		local filetype = vim.fn.expand("%:e")
		local num_lines = vim.fn.line("$")
		local file_size = vim.fn.getfsize(vim.fn.expand("%"))

		local icon, _ = devicons.get_icon(filename, filetype)

		local message =
			string.format("%s Saved %s | Lines: %d | Size: %s", icon or "", filename, num_lines, human_size(file_size))

		vim.notify(message, vim.log.levels.INFO)
	end,
})

--------------------------------------------------------------------------------------------------------------
-- Auto commands for macro recording notifications

vim.api.nvim_create_autocmd("RecordingEnter", {
	group = recording_group,
	callback = function()
		local reg = vim.fn.reg_recording()
		vim.notify("[●] Recording Macro to Register: " .. reg, vim.log.levels.INFO)
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	group = recording_group,
	callback = function()
		vim.notify("[✓] Macro Recording Finished", vim.log.levels.INFO)
	end,
})

--------------------------------------------------------------------------------------------------------------
-- Open float diagnostic on hover

vim.api.nvim_create_autocmd("CursorHold", {
	group = diagnostic_group,
	callback = function()
		local line = vim.api.nvim_win_get_cursor(0)[1] - 1
		local diagnostics = vim.diagnostic.get(0, { lnum = line })
		if #diagnostics > 0 then
			vim.diagnostic.open_float(nil, { focus = false })
		end
	end,
})
--------------------------------------------------------------------------------------------------------------
-- LSP Attach Events

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if not client then
			return
		end

		-- Disable LSP formatting
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		-- Notify when an LSP attaches
		vim.notify("󰒋 LSP Attached: " .. client.name, vim.log.levels.INFO)
	end,
})

--------------------------------------------------------------------------------------------------------------
-- Remember folds between sessions

vim.api.nvim_create_autocmd("BufWinLeave", {
	group = remember_folds_group,
	pattern = "*",
	callback = function()
		if vim.bo.buftype == "" then
			vim.cmd("silent! mkview")
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = remember_folds_group,
	pattern = "*",
	callback = function()
		if vim.bo.buftype == "" then
			vim.cmd("silent! loadview")
		end
	end,
})

--------------------------------------------------------------------------------------------------------------
-- Automatically resize splits when the editor is resized

vim.api.nvim_create_autocmd("VimResized", {
	group = resize_group,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

--------------------------------------------------------------------------------------------------------------
-- Remove trailing whitespace before saving

vim.api.nvim_create_autocmd("BufWritePre", {
	group = whitespace_group,
	pattern = "*",
	callback = function()
		local cursor = vim.api.nvim_win_get_cursor(0)

		vim.cmd([[%s/\s\+$//e]])

		vim.api.nvim_win_set_cursor(0, cursor)
	end,
})

--------------------------------------------------------------------------------------------------------------
-- Automatically create missing directories before saving

vim.api.nvim_create_autocmd("BufWritePre", {
	group = mkdir_group,
	callback = function(args)
		local dir = vim.fn.fnamemodify(args.file, ":p:h")

		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

--------------------------------------------------------------------------------------------------------------
-- Updatetime setting for better CursorHold responsiveness

-- The default updatetime (4000ms) is too slow for diagnostic hover to feel responsive.
-- Lowering it to 300ms makes the float diagnostic appear more quickly while still
-- being conservative enough to avoid performance issues.
vim.o.updatetime = 300

-- End of configuration
