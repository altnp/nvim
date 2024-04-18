-- TODO: enable buffer for only specific cmds ('s')
-- TODO: more highlights (https://github.com/hrsh7th/n-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu)
-- TODO: complteopt preview?
-- TODO: prioritize & limit # of completions

local function kind_overrides(entry, item)
  local override = {}
  local icons = require 'ui.icons'

  if vim.tbl_contains({ 'cmdline', 'cmdline-short' }, entry.source.name) then
    override.icon = icons['Event']
    override.hl_group = 'CmpItemKindEvent'
    override.kind = 'Cmd'
  elseif entry.source.name == 'path' then
    local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
    override.icon = icon
    override.hl_group = hl_group
  end

  return override
end

local formatting_style = {
  fields = { 'abbr', 'kind', 'menu' },
  format = function(entry, item)
    local overrides = kind_overrides(entry, item)
    local icons = require 'ui.icons'
    local icon = ' ' .. (overrides.icon or icons[item.kind] or '') .. ' '

    item.kind = string.format('%s %s', icon, overrides.kind or item.kind)
    item.kind_hl_group = overrides.hl_group or item.kind_hl_group
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
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdLineEnter' },
    dependencies = {
      'kawre/neotab.nvim',
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

      return {
        completion = {
          completeopt = 'menu,menuone',
        },
        window = {
          completion = {
            side_padding = 1,
            winhighlight = 'Normal:Normal,CursorLine:PmenuSel,Search:None',
            scrollbar = true,
            maxheight = 5,
            border = border 'LspInfoBorder',
          },
          documentation = {
            border = border 'LspInfoBorder',
            winhighlight = 'Normal:Normal',
          },
        },
        formatting = formatting_style,
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          -- { name = 'buffer' },
          { name = 'nvim_lua' },
          { name = 'path' },
        },
        experimental = {
          -- ghost_text = { hl_group = 'DiagnosticUnnecessary' },
        },
        matching = {
          -- disallow_fuzzy_matching = true,
        },
        mapping = {
          ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'c', 'i', 's' }),
          ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'c', 'i', 's' }),
          -- ['<M-Space>'] = cmp.mapping(cmp.mapping.complete { config = { matching = { disallow_fuzzy_matching = false } } }, { 'c', 'i', 's' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'c', 'i', 's' }),
          ['<Esc>'] = cmp.mapping(cmp.mapping.close(), { 'c', 'i', 's' }),

          ['<CR>'] = cmp.mapping(
            cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            },
            { 'i', 's' }
          ),

          ['<Tab>'] = cmp.mapping(function(_)
            local neotab = require 'neotab'
            if cmp.visible() then
              cmp.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
              }
            elseif require('luasnip').expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
            else
              neotab.tabout()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if require('luasnip').jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
      }
    end,
    config = function(_, opts)
      local cmp = require 'cmp'
      local source = {
        get_keyword_pattern = function()
          return [[\k\+]]
        end,
        complete = function(_, _, callback)
          callback {
            { label = 'w' },
            { label = 'q' },
            { label = 'qa' },
            { label = 'so' },
            { label = 'Ex' },
          }
        end,
      }
      cmp.register_source('cmdline-short', source)
      cmp.setup(opts)

      local cmpMapping = {
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item {}, { 'c', 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'c', 'i', 's' }),
      }

      cmp.setup.cmdline('/', {
        completion = {
          completeopt = 'menu,menuone,noselect',
        },
        sources = {
          { name = 'buffer' },
        },
        mapping = cmpMapping,
      })

      cmp.setup.cmdline(':', {
        completion = {
          completeopt = 'menu,menuone,noselect',
        },
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline-short',
          },
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
          },
        }, {
          {
            name = 'buffer',
          },
        }),
        mapping = cmpMapping,
      })
    end,
  },
}
