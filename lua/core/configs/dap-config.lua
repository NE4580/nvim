-- Set up C++ debugging with cpptools
local dap = require('dap')
dap.adapters.codelldb =
{
	type = 'server',
	port = 13000,
	executable =
	{
		command = '~/.local/share/nvim/mason/bin/codelldb', -- Ensure this is in your PATH, as Mason installs this tool
		args = { '--port', '13000' },
	}
}

dap.configurations.cpp =
{
	{
		name = 'Launch',
		type = 'codelldb',
		request = 'launch',
		program = vim.fn.getcwd() .. "/a.out",
		args = {},
		stopAtEntry = false,
		cwd = '${workspaceFolder}',
		environment = {},
		externalConsole = false,
		MIMode = 'gdb', -- Can also use 'lldb' or 'cppdbg'
		miDebuggerPath = '/usr/bin/gdb', -- Make sure gdb is installed
		setupCommands =
		{
			{
				text = '-enable-pretty-printing',
				description = 'Enable pretty printing',
				ignoreFailures = false,
			},
			{
				text = "-gdb-set logging off",
				description = "Disable logging in GDB"
			}
		},
		sourceFileMap = { ['/usr/src'] = '${workspaceFolder}' },
	},
}

local dapui = require('dapui')

dap.listeners.after['event_initialized']['dap_config'] = function () dapui.open() end
-- Close dap-ui when the session is terminated or exited
dap.listeners.after['event_terminated']["dapui_config"] = function() dapui.close() end
dap.listeners.after['event_exited']["dapui_config"] = function() dapui.close() end

dapui.setup({
	controls =
	{
		element = "repl",
		enabled = true,
		icons =
		{
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = ""
		}
	},
	element_mappings = {},
	expand_lines = true,
	floating =
	{
		border = "rounded",
		mappings = { close = { "q", "<Esc>" } }
	},
	force_buffers = true,
	icons =
	{
		collapsed = "",        -- Icon for collapsed items
		expanded = "",         -- Icon for expanded items
		current_frame = "→"     -- Icon for the current frame (different from collapsed)
	},
	layouts =
	{
		{
			elements =
			{
				{ id = "watches", size = 0.25 },
				{ id = "breakpoints", size = 0.25 },
				{ id = "stacks", size = 0.25 },
				{ id = "scopes", size = 0.25 },
			},
			position = "left", size = 40
		},
		{
			elements =
			{
				{ id = "console", size = 0.6 },
				{ id = "repl", size = 0.4 },
			},
			position = "bottom", size = 12
		},
	},
	mappings =
	{
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t"
	},
	render = { indent = 1, max_value_lines = 100 }
})
