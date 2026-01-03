return
{
  require('plugins.lsp.mason'),           -- Mason package manager
  require('plugins.lsp.nvimlsp'),         -- Nvin-lspconfig
  require('plugins.lsp.treesitter'),      -- Tree-sitter configurations
--	{ "ray-x/lsp_signature.nvim", config = function ()
--		require("lsp_signature").setup({
--			bind = true,
--			handler_opts = { border = "rounded" },
--		})
--	end
--	},
--  	config = function()
--      local servers = { 'lua_ls', 'clangd', 'pyright', 'bashls', 'html', 'cssls' } -- Add the language servers you need
--      for _, server in ipairs(servers) do
--        vim.lsp.enable(server)
--      end
--  	end
}
