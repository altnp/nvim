return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup {
      render = 'compact',
      stages = 'fade_in_slide_out',
      timeout = 500,
      level = 'WARN',
    }
  end,
}
