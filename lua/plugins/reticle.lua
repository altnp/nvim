return {
  'tummetott/reticle.nvim',
  event = 'User FilePost',
  config = function()
    require('reticle').setup {
      disable_in_insert = false,
      ignore = {
        cursorline = {
          'noice', -- Added noice to defaults
          'DressingInput',
          'FTerm',
          'NvimSeparator',
          'neo-tree-popup',
          'Nvimtree',
          'TelescopePrompt',
          'Trouble',
        },
      },
    }
  end,
}
