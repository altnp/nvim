return {
  'mbbill/undotree',
  keys = {
    { '<leader>u', mode = 'n', desc = 'Toggle Undotree' },
  },
  config = function()
    vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { silent = true, desc = 'Toggle Undotree' })
    vim.g.undotree_WindowLayout = 3
    vim.g.undotree_DiffAutoOpen = 1
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_HelpLine = 0
  end,
}
