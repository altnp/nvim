return {
  'tummetott/reticle.nvim',
  event = 'User FilePost',
  opts = {
    disable_in_insert = false,
    ignore = {
      cursorline = {
        'noice', -- Added noice to defaults
        'DressingInput',
        'FTerm',
        'NvimSeparator',
        'NvimTree',
        'TelescopePrompt',
        'Trouble',
      },
    },
  },
}
