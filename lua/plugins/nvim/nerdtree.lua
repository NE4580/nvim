return
{
	{
		'preservim/nerdtree', cmd = 'NERDTreeToggle',
		config = function()
			vim.g.NERDTreeQuitOnOpen = 1 -- close after opening a file
			vim.g.NERDTreeGitStatus = 1
		end
	},
	{ 'ryanoasis/vim-devicons' },
	{ 'tiagofumo/vim-nerdtree-syntax-highlight' }
}
