return
{
	{ 'nvim-mini/mini.icons', version = false },
	{ 'catppuccin/nvim', as = 'catppuccin' },

	{
		"derekwyatt/vim-protodef",
		config = function()
			vim.g.ProtodefProtoTypeFname = "prototype.{c|cpp|h|hpp}"
		end,
	},

	{
		"windwp/nvim-autopairs", event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({ map_cr = false })
		end,
	},

	-- INDENTATION HANDLED BY SNACKS

	{
		"derekwyatt/vim-fswitch",
		ft = { "c", "cpp", "h", "hpp" },
		config = function()
			vim.g.fswitchlocs = 'reg:/include/src/,reg:/src/include/, rel:.'
			vim.g.fswitch_extensions = 'h,cpp,c,cc,hpp'
		end,
	},
}
