---- Unmap LSP default keybindings for all sessions
vim.api.nvim_del_keymap('n', 'gra')  -- Normal mode
vim.api.nvim_del_keymap('n', 'gri')  -- Normal mode
vim.api.nvim_del_keymap('n', 'grn')  -- Normal mode
vim.api.nvim_del_keymap('n', 'grr')  -- Normal mode
vim.api.nvim_del_keymap('n', 'grt')  -- Normal mode
vim.api.nvim_del_keymap('n', 'gO')   -- Normal mode
vim.api.nvim_del_keymap('v', 'gra')  -- Visual mode

--- Leader Key ----
vim.g.mapleader = " "

---- Editor Basics ----
vim.opt.wrap = false
vim.opt.number = true
vim.opt.showtabline = 2
vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.cul = true

---- Indentation ----
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.smartindent = true

-- Initialize Lazy.nvim
local lazypath = vim.fn.stdpath("config") .. "/lua/lazy"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin Setup
require('lazy').setup({
--	NVIM LSP
	require('plugins.lsp.backend'),
	require('plugins.nvim.completion'),
	require('plugins.lsp.format'),

--	NVIM ENVIRONMENT PLUGINS
	require('plugins.nvim.nerdtree'),
	require('plugins.nvim.lualine'),
  require('plugins.nvim.cmdline'),

	-- require('plugins.nvim.notify'),
	require('plugins.nvim.whichkey'),
	require('plugins.nvim.utils'),
	require('plugins.nvim.telescope'),
	require('plugins.nvim.tagbar'),
	require('plugins.nvim.toggleterm'),
	require('plugins.nvim.neogit'),
	require('plugins.nvim.diffview'),

	--DAP PROTOCOL
	require('plugins.nvim.nvim-dap'),

	--SNACKS
	require('plugins.nvim.snacks')
})

-- LSP SERVER SETUP
require('core.configs.lsp-globals')
require('lspEnabler')

-- Set UI color
require('core.configs.colorscheme')

-- Load Plugin Configurations
require('core.configs.autocmds')
require('core.configs.completion')

-- Load mappings
require('core.keymaps.mappings')

-- Load the CMake workspace module && Set up key mapping for wsm
require('core.custom.cmake-wsm')
require('core.configs.wsm-cfg')

-- Set up nvim-dap for C/C++
require('core.configs.dap-config')
