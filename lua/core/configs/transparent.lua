-- Optional, you don't have to run setup.
require("transparent").setup({
	-- table: default groups
	groups = {
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"CursorLine",
		"CursorLineNr",
		"StatusLine",
		"StatusLineNC",
		"Pmenu",
		"Hover",
		"NormalFloat",
		"EndOfBuffer",
	},
	-- table: additional groups that should be cleared
	extra_groups = { "FloatBorder", "FloatTitle", "FloatFooter" },
	-- table: groups you don't want to clear
	exclude_groups = {},
	-- function: code to be executed after highlight groups are cleared
	on_clear = function() end,
})
