return
{
  { 'williamboman/mason.nvim', event = 'VeryLazy', run = ':MasonUpdate',-- Automatically update after installation
  config = function()
    require('mason').setup({
      ensure_installed = {
				'lua_ls',
				'clangd',
				'omnisharp',
				'pyright',
				'bashls',
				'html',
				'cssls',
				'codelldb',
				'clang-format'
			}
		}) --initialize Mason
  end
  },

  { 'williamboman/mason-lspconfig.nvim', after = 'mason.nvim',-- Load this after Mason
  config = function()
    require('mason-lspconfig').setup {
      automatic_enable = true,
    }
  end
  },
}
