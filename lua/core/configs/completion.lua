local cmp = require('cmp')
-- Setup nvim-cmp
cmp.setup({
	snippet = {
		expand = function(args)
			-- Use `LuaSnip` as the snippet engine
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<TAB>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()  -- fallback to default Tab behavior
			end
		end, { 'i', 's' }),  -- Insert and Select mode

		['<S-TAB>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()  -- fallback to default Shift-TAB behavior
			end
		end, { 'i', 's' }),

		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = { 
		{ name = 'nvim_lsp' },
		{ name = 'buffer', keyword_lenghth = 3, max_item_count = 8 },
		{ name = 'path' },
		{ name = 'luasnip' },
		{ name = 'nvim_lua' },
	},
	-- Customize the popup appearance
	window = {
		completion = {
			max_items = 8,
			sorting = {
				comparators = {
					cmp.config.compare.offset,  -- Sort based on the offset in the current buffer
					cmp.config.compare.exact,   -- Prioritize exact matches
					cmp.config.compare.score,   -- Sort based on score (most relevant suggestions)
				},
				{ completeopt = "menu, menuone, noinsert", },
			},
			-- Border style (rounded corners)
			border = { { '╭', 'FloatBorder' }, { '─', 'FloatBorder' }, { '╮', 'FloatBorder' }, { '│', 'FloatBorder' }, { '╯', 'FloatBorder' }, { '─', 'FloatBorder' }, { '╰', 'FloatBorder' }, { '│', 'FloatBorder' }, },
			winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
			col_offset = 0,  -- Adjust if needed
			side_padding = 1,
			max_width = 32,  -- Change to your desired width
			min_width = 16,   -- Change to your desired minimum width
		},
		documentation = { border = 'rounded', },  -- or 'single'
		-- command line completions
		cmp.setup.cmdline(':', {
			-- mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'cmdline' }, -- use cmp for cmdline completions
				{ name = 'path' }, -- path completions
			}
		}),
		-- commad line completions for '/' and '?' (search)
		cmp.setup.cmdline('/', { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' }, }}),
		cmp.setup.cmdline('?', { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' }, }})
	},
})
