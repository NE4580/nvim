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
	require('plugins.lsp.lsp'),
	require('plugins.nvim.completion-fw'),

--	NVIM ENVIRONMENT PLUGINS
	require('plugins.nvim.nerdtree'),
	require('plugins.nvim.lualine'),
	require('plugins.nvim.cmdline'),
	require('plugins.nvim.notify'),
	require('plugins.nvim.whichkey'),
	require('plugins.nvim.utils'),
	require('plugins.nvim.telescope'),
	require('plugins.nvim.tagbar'),
	require('plugins.nvim.toggleterm'),
	require('plugins.nvim.neogit'),
	require('plugins.nvim.diffview'),
})
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
