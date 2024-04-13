return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'Mofiqul/vscode.nvim',
  },
  config = function()
    require('nvim-tree').setup {}
  end,
}
