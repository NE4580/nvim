return 
{
	local servers = { 'lua_ls', 'clangd', 'pyright', 'bashls', 'html', 'cssls' } -- Add the language servers you need
	for _, server in ipairs(servers) do
		vim.lsp.enable(server)
	end
}
