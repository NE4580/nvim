require("bufferline").setup({
	options = {
		mode = "buffers",
		-- numbers = "ordinal",
		numbers = function(opts)
			return string.format("%s", opts.raise(opts.ordinal))
		end,

		indicator = {
			icon = " ",
			style = "icon", -- "icon" | "underline" | "none",
		},
		modified_icon = "● ",
		left_trunc_marker = " ",
		right_trunc_marker = " ",

		diagnostics = "nvim_lsp",
		diagnostics_update_on_event = true, -- use nvim's diagnostic handler
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and "󰅚 " or level:match("warn") and "󰀪 " or "" -- default icon
			-- local icon = level:match("error") and "󰅚 " or "󰀪 "
			return "" .. icon .. count
		end,

		show_buffer_icons = false,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		show_duplicate_prefix = true,

		auto_toggle_bufferline = true,
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
	},
})
