-- ~/.config/nvim/lsp/bashls.lua
return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash", "zsh" },
	root_markers = { ".git", ".bashrc", ".zshrc", "package.json" },

	-- Disable signature help globally (already handled by your global config)
	-- init_options = {}, -- No special init_options needed for bashls

	handlers = {
		vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false,
			signs = false,
			underline = false,
			update_in_insert = false,
		}
	},

	-- Optional: Bash-specific settings
	settings = {
		bashIde = {
			-- Enable/disable specific features
			enableSourceErrorDiagnostics = true,
			explainshellEndpoint = "",  -- Set to "" to disable explainshell integration
			globPattern = "**/*@(.sh|.inc|.bash|.command)",  -- Files to analyze
			-- Set to false if you don't want hover documentation
			includeAllWorkspaceSymbols = false,
		}
	}
}
