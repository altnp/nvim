return {
  'kawre/neotab.nvim',
  opts = {
    tabkey = '',
    act_as_tab = true,
    behavior = 'nested',
    pairs = {
      { open = '(', close = ')' },
      { open = '[', close = ']' },
      { open = '{', close = '}' },
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = '`', close = '`' },
      { open = '<', close = '>' },
    },
    exclude = {},
    smart_punctuators = {
      enabled = false,
    },
  },
}
