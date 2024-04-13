local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end

local function show_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
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
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
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
      lualine_x = { show_macro_recording, 'encoding', 'fileformat' },
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
  },
  config = function(_, opts)
    local lualine = require 'lualine'
    lualine.setup(opts)

    vim.api.nvim_create_autocmd('RecordingEnter', {
      callback = function()
        lualine.refresh {
          place = { 'statusline' },
        }
      end,
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
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
  end,
}
