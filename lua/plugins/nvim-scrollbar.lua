return {
  'petertriho/nvim-scrollbar',
  event = 'User FilePost',
  dependencies = {
    'lewis6991/gitsigns.nvim',
  },
  config = function()
    require('scrollbar.handlers.gitsigns').setup()
    require('scrollbar').setup {
      hide_if_all_visible = true,
      throttle_ms = 10,
      marks = {
        Cursor = {
          highlight = 'CursorColumn',
          text = ' ',
        },
      },
    }
  end,
}
