-- ~/.config/nvim/lsp/cssls.lua
return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "sass", "less" },
	root_markers = { "package.json", ".git", "vite.config.js", "style.config.js" },

	handlers = {
		vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false,
			signs = false,
			underline = false,
			update_in_insert = false,
		}
	},

	init_options = {
		-- Provide document format settings
		provideFormatter = true,
	},

	-- Optional: CSS-specific settings
	settings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
			completion = {
				completePropertyWithSemicolon = true,
			},
			hover = {
				documentation = true,
			},
		},
		scss = {
			validate = true,
		},
		less = {
			validate = true,
		},
	},
}
