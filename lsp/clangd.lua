-- ~/.config/nvim/lsp/clangd.lua
return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",           -- Enable clang-tidy diagnostics
		"--suggest-missing-includes",
		"--cross-file-rename",    -- Better rename across files
		"--completion-style=detailed",
		"--header-insertion=iwyu", -- Don't auto-insert headers
		"--header-insertion-decorators" -- Provide details on why header is included
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },

	handlers = {
		vim.lsp.diagnostic.on_publish_diagnostics, {
			-- Turn off all default visual popups/underlines
			virtual_lines = false,
			virtual_text = false,
			signs = false,
			underline = true,
			serverity_sort = true,
			-- Prevents diagnostics from updating while you type
			update_in_insert = false,
			float = { border = "rounded", source = "always", },
		}
	},

	root_markers = {
		"compile_commands.json",
		".git",
		"compile_flags.txt"
	},
	init_options = {
		clangdFileStatus = true,
		usePlaceholders = true,
		completeUnimported = true,
		semanticHighlighting = true,
		signatureHelp = false,
	},
}
