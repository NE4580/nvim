-- ~/.config/nvim/lsp/lua_ls.lua
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },

	-- Disable signature help
	init_options = {
		signatureHelp = false
	},

	handlers = {
		vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_lines = false,
			virtual_text = false,
			signs = false,
			underline = false,
			update_in_insert = false,
		}
	},

	-- Optional: Lua-specific settings
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- Avoid "workspace not configured" warnings
			},
			-- Disable telemetry
			telemetry = {
				enable = false,
			},
		}
	}
}
