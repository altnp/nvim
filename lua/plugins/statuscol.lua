return {
  'luukvbaal/statuscol.nvim',
  event = 'VeryLazy',
  config = function()
    local builtin = require 'statuscol.builtin'
    require('statuscol').setup {
      foldfunc = 'builtin',
      setopt = true,
      relculright = true,
      ft_ignore = { 'neotree' },
      segments = {
        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
        { text = { '%s' }, click = 'v:lua.ScSa' },
        {
          text = { builtin.lnumfunc, ' ' },
          condition = { true, builtin.not_empty },
          click = 'v:lua.ScLa',
        },
        -- {
        --   sign = { name = { 'Diagnostic' }, maxwidth = 2, auto = true },
        --   click = 'v:lua.ScSa',
        -- },
        -- { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
        -- { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
        -- {
        --   sign = { name = { '.*' }, maxwidth = 1, colwidth = 1, auto = true },
        --   click = 'v:lua.ScSa',
        -- },
      },
    }
  end,
}
