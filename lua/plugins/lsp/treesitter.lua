return
{
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', -- Automatically update parsers during installation
  config = function()
    require('nvim-treesitter.config').setup {
      ensure_installed = {"maintained", "markdown", "vimdoc" }, -- Install all maintained parsers
      highlight = { enable = true, }, -- Enable highlighting
      autopairs = { enable = true, } -- Enable automatic pairs for parentheses, etc.
    }
  end
  }
}
