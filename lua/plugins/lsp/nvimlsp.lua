return 
{
	{ 'neovim/nvim-lspconfig', after = 'mason-lspconfig.nvim', -- LSP configurations
	event = "VimEnter",
	config = function()
		vim.diagnostic.config({
			virtual_text = false,
			underline = true,
			signs = true,
			serverity_sort = true,
			update_in_insert = false,
			float = { border = "rounded", source = "always", },
		})
		local servers = { 'lua_ls', 'clangd', 'pyright', 'bashls', 'html', 'cssls' } -- Add the language servers you need
		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end
	end
},}
