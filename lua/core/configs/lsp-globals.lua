vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = false,
	underline = false,
	severity_sort = true,
	update_in_insert = false,

	-- Enable signs to show our icons
	signs =
	{
		text =
		{
			[vim.diagnostic.severity.ERROR] ='󰅚',
			[vim.diagnostic.severity.WARN] = '󰀪',
			[vim.diagnostic.severity.INFO] = '',
			[vim.diagnostic.severity.HINT] = '',
		},
		numhl =
		{
			[vim.diagnostic.severity.WARN] = 'WarningMsg',-- Highlight line with warning
			[vim.diagnostic.severity.ERROR] = 'ErrorMsg', -- Highlight line with error
		}
	},
	float = { border = "rounded", focusable = false, style = "minimal" },
})
