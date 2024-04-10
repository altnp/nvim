-- TODO: enable buffer for only specific cmds
-- TODO: update icons (https://code.visualstudio.com/docs/editor/intellisense#_types-of-completions)
-- TODO: highlights (https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu)
-- TODO: complteopt preview?
return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdLineEnter' },
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'windwp/nvim-autopairs',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-cmdline',
    },
    opts = function()
      local cmp = require 'cmp'

      local formatting_style = {
        fields = { 'abbr', 'kind', 'menu' },
        format = function(_, item)
          local icons = require 'ui.icons'
          local icon = ' ' .. (icons[item.kind] or '') .. ' '

          item.kind = string.format('%s %s', icon, item.kind)
          return item
        end,
      }

      local function border(hl_name)
        return {
          { '╭', hl_name },
          { '─', hl_name },
          { '╮', hl_name },
          { '│', hl_name },
          { '╯', hl_name },
          { '─', hl_name },
          { '╰', hl_name },
          { '│', hl_name },
        }
      end

      return {
        completion = {
          completeopt = 'menu,menuone',
        },
        window = {
          completion = {
            side_padding = 1,
            winhighlight = 'Normal:CmpPmenu,CursorLine:CmpSel,Search:None',
            scrollbar = true,
            border = border 'LspInfoBorder',
          },
          documentation = {
            border = border 'LspInfoBorder',
            winhighlight = 'Normal:CmpDoc',
          },
        },
        formatting = formatting_style,
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require 'cmp'

      cmp.setup(opts)

      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
            keyword_length = 3,
          },
        }, {
          {
            name = 'buffer',
            keyword_length = 3,
          },
        }),
      })
    end,
  },
}
