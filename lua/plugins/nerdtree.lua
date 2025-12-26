return{
	{ 'preservim/nerdtree', cmd = 'NERDTreeToggle',
		config = function()
			vim.g.NERDTreeQuitOnOpen = 1 -- close after opening a file
		end
  },
  { 'ryanoasis/vim-devicons' }
}
