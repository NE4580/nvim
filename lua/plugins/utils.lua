return {
	{ "derekwyatt/vim-protodef",
		config = function()
			vim.g.ProtodefProtoTypeFname = "prototype.{c|cpp|h|hpp}"
		end,
	},
{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  config = function ()
    require('diffview').setup({
      use_icons = true,
      icons = {
        folder_closed = "",
        folder_open = "",
        added = "",
        modified = "✎",
        removed = "",
      },
			layout = {
				default = {
					layout = "focus",
					height = 32,
					winbar = true,
				},
			},
			view = {
				default = {
					mappings = {
						['<C-c>'] = '<cmd>DiffviewClose<CR>',
						['<C-t>'] = '<cmd>DiffviewToggleFiles<CR>',
					},
				}, 
			},
			ignore_whitespace = true,
			commit_log_entry_format = {
				format = 'short',
			},
			file_finder = {
				enable = true,
				finder = 'fzf',
			},
    })
  end,
},
	{ 'nvim-telescope/telescope.nvim', dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },  -- For fzf-native
			{ 'nvim-telescope/telescope-media-files.nvim' },  -- Media files
			{ 'nvim-telescope/telescope-file-browser.nvim' },  -- File browser
		},
		config = function()
			require('telescope').setup {
				defaults = {
					prompt_prefix = "> ",
					selection_caret = ">> ",
					entry_prefix = "  ",
					color_devicons = true,
					mappings = {
						i = {
							["<C-n>"] = "move_selection_next",
							["<C-p>"] = "move_selection_previous",
							["<C-c>"] = "close",
						},
					},
				},
				pickers = {
					find_files = {
						theme = "dropdown",
						previewer = true,
					},
				},
			}
			-- Load Telescope Extensions
			local telescope = require('telescope')
			telescope.load_extension('fzf')
			telescope.load_extension('media_files')
			telescope.load_extension('file_browser')
		end,
	},

	{ "TimUntersberger/neogit", dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require('neogit').setup({
				autoRefresh = true,
				kind = "floating",
				integrations = {
					diffview = true,
					telescope = true,
				},
				signs = {
					section = { "▸", "▾" },
					item = { "●", "○" },
					ntracked = { "★", "☆" },
				},
			})
		end
	},

	{ "windwp/nvim-autopairs", event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({ map_cr = false })
		end,
	},

	{ "lukas-reineke/indent-blankline.nvim", main = "ibl",
		opts = {
			indent = { char = "|" }
		},
	},

	{ "derekwyatt/vim-fswitch", ft = { "c", "cpp", "h", "hpp" },
		config = function()
			vim.g.fswitchlocs = 'reg:/include/src/,reg:/src/include/, rel:.'
			vim.g.fswitch_extensions = 'h,cpp,c,cc,hpp'
		end,
	},

	{ 'folke/which-key.nvim', event = 'VeryLazy',
		config = function()
			require('which-key').setup({ win = { border = "rounded" } })
		end,
	},

	{ 'catppuccin/nvim', as = 'catppuccin' },

	{ 'akinsho/toggleterm.nvim',
		config = function()
			require("toggleterm").setup {
				size = 20,
				open_mapping = [[<c-t>]],
				shade_filetypes = {},
				shade_terminals = true,
				start_in_insert = true,
				persist_size = true,
				direction = 'horizontal',
				float_opts = {
					border = "double",
					winblend = 1,
					width = 75,
					size = 32,
					title_pos = "left",
					title = "CMD: {}"
				},
			}
		end
	},
}
