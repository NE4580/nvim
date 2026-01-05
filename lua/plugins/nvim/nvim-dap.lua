return
{
	{
		"mfussenegger/nvim-dap",
		config = function ()
			local keymaps =
			{
				{ "<leader>dc", ":lua require'dap'.continue()<CR>", desc = "Start/Continue Debugging" },
				{ "<leader>dx", ":lua require'dap'.close(); require'dapui'.close()<CR>", desc = "Stop Debugging" },

				-- Stepping through code
				{ "<Leader>ds", ":lua require'dap'.step_over()<CR>", desc = "Step Over" },
				{ "<Leader>di", ":lua require'dap'.step_into()<CR>", desc = "Step Into" },
				{ "<Leader>dd", ":lua require'dap'.step_out()<CR>", desc = "Step Out" },
				{ "<Leader>dr", ":lua require'dap'.run_to_cursor()<CR>", desc = "Run to Cursor" },
				{ "<Leader>dp", ":lua require'dap'.pause()<CR>", desc = "Pause execution" },

				-- Breakpoints
				{ "<Leader>dbb", ":lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
				{ "<Leader>dbc", ":lua require'dap'.set_breakpoint(vim.fn.input('Condition: '), vim.fn.input('Place on Line: '), nil)<CR>", desc = "Set Conditional Breakpoint @Line" },
				{ "<Leader>dbx", ":lua require'dap'.clear_breakpoints()<CR>", desc = "Clear All Breakpoints" },

				-- Watch Expression
				{ "<Leader>de", ":lua require'dapui'.eval()<CR>", desc = "Evaluate expression under cursor" },
				{ "<Leader>dwa", ":lua require'dapui'.elements.watches.add(vim.fn.input('Watch Expression: '))<CR>", desc = "Add watch Expression" },
				{ "<Leader>dwe", ":lua require'dapui'.elements.watches.edit(tonumber(vim.fn.input('Index: ')), vim.fn.input('New Expression: '))<CR>", desc = "Edit watch Expression at Index" },
				{ "<Leader>dwt", ":lua require'dapui'.elements.watches.toggle_expand(tonumber(vim.fn.input('Toggle Watch @ index: ')))<CR>", desc = "Toggle watch Expression" },
				{ "<Leader>dwd", ":lua require'dapui'.elements.watches.remove(vim.fn.input('Remove Watch @ index: '))<CR>", desc = "Remove Watch Expression" },

				-- Toggle UI (dapui)
				{ "<Leader>du", ":lua require'dapui'.toggle()<CR>", desc = "Toggle Debugger UI" },
			}

			-- Apply keymaps to Lazy.nvim system
			for _, map in ipairs(keymaps) do
				vim.api.nvim_set_keymap('n', map[1], map[2], {noremap = true, silent = true, desc = map.desc})
			end
		end,
	},

{ "nvim-neotest/nvim-nio", }, -- nvim-nio, required by nvim-dap-ui

{
	"jay-babu/mason-nvim-dap.nvim", event = "VeryLazy",
	dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
	opts = { handlers = {} },
},

{
	"rcarriga/nvim-dap-ui", event = "VeryLazy", dependencies = "mfussenegger/nvim-dap",
	config = function ()
		require('dapui').setup()
	end,
}
}
