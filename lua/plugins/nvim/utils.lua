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
}
