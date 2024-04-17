-- TODO: use highlight instead of hardcoded colors for Macro Recording Status
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return ' @' .. recording_register
  end
end

local function show_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
end

local function show_lsp_progress()
  return require('lsp-progress').progress()
end

local fmt_filename = function(str, _)
  for _, v in ipairs { 'NvimTree' } do
    if vim.startswith(str, v) then
      return ''
    end
  end
  return str
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      'linrongbin16/lsp-progress.nvim',
      opts = {
        series_format = function(title, _, percentage, _)
          local builder = {}
          local has_title = false
          if type(title) == 'string' and string.len(title) > 0 then
            table.insert(builder, title)
            has_title = true
          end
          if percentage and has_title then
            table.insert(builder, string.format('(%.0f%%)', percentage))
          end
          return table.concat(builder, ' ')
        end,
      },
    },
  },
  config = function()
    local lualine = require 'lualine'
    lualine.setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          'mode',
        },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          {
            'filetype',
            icon_only = true,
            padding = {
              right = 0,
              left = 1,
            },
          },
          {
            'filename',
            symbols = {
              modified = '',
              newfile = '',
              unnamed = '',
              readonly = '',
            },
            fmt = fmt_filename,
            padding = {
              right = 0,
              left = 0,
            },
          },
        },
        lualine_x = {
          {
            show_macro_recording,
            color = { fg = '#c74e39' },
          },
          {
            require('noice').api.status.command.get,
            cond = require('noice').api.status.command.has,
          },
          show_lsp_progress,
          'encoding',
          'fileformat',
        },
        lualine_y = { 'progress' },
        lualine_z = { show_cwd },
      },
      inactive_sections = {},
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {
        'trouble',
      },
    }

    vim.api.nvim_create_augroup('LualineUpdates', { clear = true })
    vim.api.nvim_create_autocmd('RecordingEnter', {
      group = 'LualineUpdates',
      callback = function()
        lualine.refresh {
          place = { 'statusline' },
        }
      end,
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
      group = 'LualineUpdates',
      callback = function()
        local timer = vim.loop.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            lualine.refresh { place = { 'statusline' } }
          end)
        )
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      group = 'LualineUpdates',
      pattern = 'LspProgressStatusUpdated',
      callback = require('lualine').refresh,
    })
  end,
}
