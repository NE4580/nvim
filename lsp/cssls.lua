-- ~/.config/nvim/lsp/cssls.lua
return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "sass", "less" },
	root_markers = { "package.json", ".git", "vite.config.js", "style.config.js" },

	init_options = {
		-- Provide document format settings
		provideFormatter = true,
	},

	handlers = {},

	-- Optional: CSS-specific settings
	settings = {
		css = {
			validate = true,
			lint = { unknownAtRules = "ignore" },
			completion = { completePropertyWithSemicolon = true },
			hover = { documentation = true },
		},
		scss = { validate = true },
		less = { validate = true },
	},
}
