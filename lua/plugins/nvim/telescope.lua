return
{
	{
		'nvim-telescope/telescope.nvim',
		dependencies =
		{
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', build = 'make' },  -- For fzf-native
			{ 'nvim-telescope/telescope-media-files.nvim' },  -- Media files
			{ 'nvim-telescope/telescope-file-browser.nvim' },  -- File browser
			{ 'nvim-telescope/telescope-frecency.nvim',
			requires = { 'tami5/sqlite.lua' }
		},  -- Add frecency here
	},
	config = function()
		require('telescope').setup
		{
			defaults =
			{
				prompt_prefix = "> ",
				selection_caret = ">> ",
				entry_prefix = "  ",
				color_devicons = true,
				mappings =
				{
					i =
					{
						["<C-n>"] = "move_selection_next",
						["<C-p>"] = "move_selection_previous",
						["<C-c>"] = "close",
						["<C-u>"] = false, -- Disable C-u to avoid accidental closing
						["<C-d>"] = false, -- Disable C-d for visual purpose
					},
				},
			},
			pickers =
			{
				find_files = { theme = "dropdown", previewer = true },
				live_grep =
				{
					theme = "dropdown",
					previewer = true,
					additional_args = function()
						return { "--hidden" } --include hidden files
					end
				},
				tags = { theme = "dropdown" },
			},
		}
		-- Load Telescope Extensions
		local telescope = require('telescope')
		telescope.load_extension('noice')
		telescope.load_extension('fzf')
		telescope.load_extension('media_files')
		telescope.load_extension('file_browser')
		telescope.load_extension('frecency')  -- Load frecency extension
	end
}}
