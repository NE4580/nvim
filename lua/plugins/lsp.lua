return{
	-- Mason package manager
  { 'williamboman/mason.nvim', run = ':MasonUpdate',-- Automatically update after installation
		config = function()
			require('mason').setup() --initialize Mason
		end
	},

  { 'williamboman/mason-lspconfig.nvim', after = 'mason.nvim',-- Load this after Mason
		config = function()
			require('mason-lspconfig').setup {
				automatic_enable = true,
				ensure_installed = { 'lua_ls', 'clangd', 'pyright', 'bashls', 'html', 'cssls' }
			}
		end
	},

	{ 'neovim/nvim-lspconfig', after = 'mason-lspconfig.nvim', -- LSP configurations
		event = "VimEnter",
		config = function()
			vim.lsp.handlers["textDocument/signatureHelp"] = nil
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
	},
--	{ "ray-x/lsp_signature.nvim", config = function ()
--		require("lsp_signature").setup({
--			bind = true,
--			handler_opts = { border = "rounded" },
--		})
--	end
--	},
	-- Tree-sitter configurations
	{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', -- Automatically update parsers during installation
    config = function()
        require('nvim-treesitter.config').setup {
            ensure_installed = {"maintained", "markdown", "vimdoc" }, -- Install all maintained parsers
            highlight = { enable = true, }, -- Enable highlighting
            autopairs = { enable = true, } -- Enable automatic pairs for parentheses, etc.
        }
    end
	},
}
