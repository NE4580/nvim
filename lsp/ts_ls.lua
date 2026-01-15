-- ~/.config/nvim/lua/lsp/javascript.lua
return {
	cmd = { "typescript-language-server", "--stdio" },

	-- Filetypes this server should attach to
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},

	-- Optional handlers (empty for now)
	handlers = {},

	-- Root markers to detect project root
	root_markers = {
		"package.json",
		"tsconfig.json",
		"jsconfig.json",
		".git",
	},

	-- Initialization options
	init_options = {
		hostInfo = "neovim",
		preferences = {
			importModuleSpecifierPreference = "relative",
			quotePreference = "auto",
			allowIncompleteCompletions = true,
		},
	},
}
