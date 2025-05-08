return {
  'nvim-lualine/lualine.nvim',
  -- TODO: needs nerd fonts to be installed
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'dracula'
      }
    })
  end
}
