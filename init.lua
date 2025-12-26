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
	require("plugins.lualine"),
	require("plugins.notify"),
	require("plugins.lsp"),
	require("plugins.utils"),
	require("plugins.auto_completions"),
	require("plugins.nerdtree"),
	require("plugins.tagbar"),
	require("plugins.cmdline"),
})

-- Load Plugin Configurations
require("configs.suggestions")
require("configs.autocmds")

-- Load mappings
require('keymaps.mappings')
