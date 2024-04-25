return {
  'norcalli/nvim-colorizer.lua',
  event = 'User FilePost',
  config = function()
    require('colorizer').setup({ '*' }, {
      RRGGBBAA = true,
      css = true,
      mode = 'background',
    })

    local f = '#FF0000'
  end,
}
