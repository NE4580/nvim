return{
	{ "derekwyatt/vim-protodef",
		config = function()
			vim.g.ProtodefProtoTypeFname = "prototype.{c|cpp|h|hpp}"
		end,
	},

	{ 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup{
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
						previewer = true,  -- Set to false if you wish to disable previewer
					},
				},
			}
			-- Load Telescope Extensions
--			require('telescope').load_extension('fzf')
--			require('telescope').load_extension('media_files')
--			require('telescope').load_extension('file_browser')
		end,
	},
-- Add Telescope Extensions
	{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },  -- For fzf-native
	{ 'nvim-telescope/telescope-media-files.nvim' },  -- Media files
	{ 'nvim-telescope/telescope-file-browser.nvim' },  -- File browser

	{ "TimUntersberger/neogit",  dependencies = { "nvim-lua/plenary.nvim" },
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
	}, -- git extension
	
	{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim",
		 cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
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

	{ "derekwyatt/vim-fswitch", ft = { "c", "cpp", "h", "hpp" },  -- Specify file types where the plugin should be active
		config = function()
			vim.g.fswitchlocs = 'reg:/include/src/,reg:/src/include/, rel:.'  -- Locations to search for headers
			vim.g.fswitch_extensions = 'h,cpp,c,cc,hpp'  -- File extensions for header/source files
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
			require("toggleterm").setup{
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

