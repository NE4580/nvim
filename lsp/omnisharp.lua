-- ~/.config/nvim/lsp/omnisharp.lua
local mason_path = vim.fn.stdpath("data") .. "/mason/bin/"

return {
	cmd = {
		mason_path .. "OmniSharp",
		"--languageserver",
		"--hostPID",
		tostring(vim.fn.getpid()),
	},

	filetypes = { "cs" },

	handlers = {},

	root_markers = {
		"OmniSharp.json",
		".git",
		"*.csproj",
		"*.sln",
	},

	init_options = {
		enableRoslynAnalyzers = true,
		enableEditorConfigSupport = true,
		organizeImports = true,
		enableImportCompletion = true,
		enableAnalyzersDiagnostics = true,
		FormattingOptions = {
			TabSize = 2,
			InsertSpaces = true,
		},
	},
}
