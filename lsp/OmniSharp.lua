return {
	cmd = {
		"OmniSharp", -- Command to start OmniSharp (ensure it’s in your PATH)
		"--languageserver", -- Start as a language server
		"--hostPID",
		tostring(vim.fn.getpid()), -- Pass the current editor's PID
	},

	filetypes = { "csharp" }, -- Filetypes for C# language server

	handlers = {},

	root_markers = {
		"OmniSharp.json", -- OmniSharp config file
		".git", -- Git repository root
		"csproj", -- Check for C# project files
	},

	init_options = {
		FormattingOptions = {
			TabSize = 2, -- Set tab size for C#
			InsertSpaces = true, -- Use spaces instead of tabs
		},
		enableRoslynAnalyzers = true, -- Enable Roslyn analyzers
		enableEditorConfigSupport = true, -- Respect .editorconfig settings
		organizeImports = true, -- Auto-organize imports on save
	},
}
