return {
  'kevinhwang91/nvim-ufo',
  event = 'User FilePost',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  config = function()
    require('ufo').setup {
      provider_selector = function(_, _, _)
        return { 'treesitter', 'indent' }
      end,
      close_fold_kinds_for_ft = {
        default = { 'comment' },
      },
    }
    vim.keymap.set('n', 'z<CR>', 'za')
    vim.keymap.set('n', 'zo', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zm', require('ufo').closeAllFolds)
  end,
}
