return {
  'anuvyklack/windows.nvim',
  event = 'User FilePost',
  dependencies = {
    'anuvyklack/middleclass',
  },
  config = function()
    require('windows').setup {
      autowidth = {
        enable = false,
      },
    }
    vim.keymap.set('n', '<M-=>', '<cmd>WindowsEqualize<CR>')
  end,
}
