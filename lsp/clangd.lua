-- ~/.config/nvim/lsp/clangd.lua
return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy", -- Enable clang-tidy diagnostics
		"--suggest-missing-includes",
		"--cross-file-rename", -- Better rename across files
		"--completion-style=detailed",
		"--header-insertion=iwyu", -- Don't auto-insert headers
		"--header-insertion-decorators", -- Provide details on why header is included
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },

	handlers = {},

	root_markers = {
		"compile_commands.json",
		".git",
		"compile_flags.txt",
	},
	init_options = {
		clangdFileStatus = true,
		usePlaceholders = true,
		completeUnimported = true,
		semanticHighlighting = true,
		signatureHelp = false,
	},
}
