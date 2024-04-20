return {
  'nvim-neo-tree/neo-tree.nvim',
  event = 'VeryLazy',
  -- branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      sources = {
        'filesystem',
      },
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      enable_modified_markers = true,
      enable_opened_markers = true,
      enable_cursor_hijack = false,
      hide_root_node = true,
      popup_border_style = 'rounded',
      sort_case_insensitive = true,
      default_component_configs = {
        modified = {
          symbol = '',
        },
        diagnostics = {
          symbols = {
            hint = '',
            info = '',
            warn = '',
            error = '',
          },
        },
        git_status = {
          symbols = {
            added = '+',
            deleted = '-',
            modified = '~',
            renamed = '',
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
        symlink_target = {
          enabled = true,
        },
      },
      commands = {
        toggle = function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w><C-p>', true, true, true), 'n', false)
        end,
      },
      window = {
        mappings = {
          ['<leader>e'] = 'toggle',
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_hidden = false,
          hide_gitignored = true,
          hijack_netrw_behavior = 'open_current',
          hide_by_name = {
            'node_modules',
            '.git',
            'bin',
            'obj',
          },
          hide_by_pattern = {},
        },
      },
    }
    vim.keymap.set('n', '<leader>e', '<cmd>Neotree<CR>', { desc = 'Focus tree explorer', silent = true })
    vim.keymap.set('n', '<leader>E', '<cmd>Neotree reveal<CR>', { desc = 'Focus tree explorer', silent = true })
  end,
}
