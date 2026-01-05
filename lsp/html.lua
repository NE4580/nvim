-- ~/.config/nvim/lsp/html.lua
return {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "htm", "handlebars", "blade", "vue", "svelte" },
	root_markers = { "package.json", ".git", "index.html", "vite.config.js" },

	handlers = {
		vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false,
			signs = false,
			underline = false,
			update_in_insert = false,
		}
	},

	init_options = {
		-- Configuration for embedded languages
		embeddedLanguages = { css = true, javascript = true },
		-- Provide document format settings
		configurationSection = { "html", "css", "javascript" },
		-- Disable specific providers if needed
		provideFormatter = true,
	},

	-- Optional: HTML-specific settings
	settings = {
		html = {
			autoClosingTags = true,
			autoCreateQuotes = true,
			format = {
				enable = true,
				wrapLineLength = 120,
				templating = false,
				wrapAttributes = "auto",
			},
			suggest = {
				html5 = true,
			},
			hover = {
				documentation = true,
				references = true,
			},
		},
		css = {},
		javascript = {},
	},
}
