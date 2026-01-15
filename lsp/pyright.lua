return {
	cmd = {
		"pyright-langserver",
		"--stdio", -- Pyright should communicate via stdin and stdout
	},

	filetypes = { "python" },

	handlers = {},

	root_markers = {
		"pyrightconfig.json", -- Pyright's config file
		".git", -- Git repository root
	},

	init_options = {
		useLibraryCodeForTypes = true, -- Enable type checking for third-party libraries
		reportMissingImports = true, -- Report missing imports
		typeCheckingMode = "basic", -- Use "basic" or "strict" for stricter checks
		pythonVersion = "3.9", -- Specify Python version (if required)
	},
}
