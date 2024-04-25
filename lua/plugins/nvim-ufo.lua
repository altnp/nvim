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
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
    -- TODO: Peak / Preview
  end,
}
