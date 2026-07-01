return {
	{ "nvim-mini/mini.icons", version = false },
	{ "catppuccin/nvim", as = "catppuccin" },
	{
		"derekwyatt/vim-protodef",
		config = function()
			vim.g.ProtodefProtoTypeFname = "prototype.{c|cpp|h|hpp}"
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				map_cr = true,
				check_ts = true,
				enable_check_bracket_line = true,
				enable_moveright = true,
			})
		end,
	},

	{
		"derekwyatt/vim-fswitch",
		ft = { "c", "cpp", "h", "hpp" },
		config = function()
			vim.g.fswitchlocs = "reg:/include/src/,reg:/src/include/, rel:."
			vim.g.fswitch_extensions = "h,cpp,c,cc,hpp"
		end,
	},
	{
		"mbbill/undotree",

		keys = {
			{
				"<leader><leader>h",
				function()
					vim.cmd.UndotreeToggle()
				end,
				desc = "Toggle UndoTree",
			},
		},

		config = function()
			-- optional settings
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SplitWidth = 35
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_DiffAutoOpen = 1
			vim.g.undotree_DiffpanelHeight = 10
			vim.g.undotree_HighlightChangedText = 1
			vim.g.undotree_HighlightChangedWithSign = 1
			vim.g.undotree_ShortIndicators = 1
		end,
	},

	{
		"sphamba/smear-cursor.nvim",
		opts = {
			-- Animate between neighbor lines
			smear_between_neighbor_lines = true,

			-- Also animate bigger jumps (like search results)
			smear_between_long_jumps = true,

			-- Animate when moving in insert mode
			smear_insert_mode = true,

			-- Animation feel: lower stiffness = more "floaty", higher = snappier
			stiffness = 0.25, -- Default: 0.3

			-- Damping: controls how quickly it stops
			damping = 0.9, -- Default: 0.9 (lower = stops faster)

			-- Animation speed limits
			min_duration_ms = 16,
			max_duration_ms = 64,

			-- Visual: make the trail more visible
			smear_color = nil, -- nil for auto
			smear_opacity = 0.35,

			-- Always smear (even for tiny movements)
			always_smear = false, -- Set to true for constant animation

			-- Use velocity for smoother animations
			use_velocity = true,
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		opts = {
			enable = true,
			mode = "cursor",
			max_lines = 5,
			line_numbers = true,
			trim_scope = "outer",

			-- Make it more visible
			multiline_threshold = 2,
			separator = "_",
			zindex = 20,
		},
	},
}
