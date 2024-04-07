return {
  'Mofiqul/vscode.nvim',
  lazy = false,
  config = function()
    require('vscode').load('dark')
  end
}
