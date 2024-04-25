local icons = require 'ui.icons'
return {
  'nvim-neo-tree/neo-tree.nvim',
  event = 'VeryLazy',
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
      use_default_mappings = false,
      default_component_configs = {
        modified = {
          symbol = '',
        },
        diagnostics = {
          symbols = {
            hint = icons.DiagnosticsSymbols.Hint,
            info = icons.DiagnosticsSymbols.Info,
            warn = icons.DiagnosticsSymbols.Warn,
            error = icons.DiagnosticsSymbols.Error,
          },
        },
        git_status = {
          symbols = {
            added = icons.GitSymbols.Added,
            deleted = icons.GitSymbols.Deleted,
            modified = icons.GitSymbols.Modified,
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
        dynamic_cancel = function(state)
          local preview = require 'neo-tree.sources.common.preview'
          local renderer = require 'neo-tree.ui.renderer'
          local fs = require 'neo-tree.sources.filesystem'

          if preview.is_active() then
            preview.hide()
          else
            if state.current_position == 'float' then
              renderer.close_all_floating_windows()
            else
              fs.reset_search(state, true)
            end
          end
        end,
      },
      window = {
        mappings = {
          ['<leader>e'] = { 'toggle' },
          ['\\'] = 'open_split',
          ['|'] = 'open_vsplit',
          ['W'] = 'close_all_nodes',
          ['<2-LeftMouse>'] = 'open',
          ['<CR>'] = 'open',
          ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = false } },
          ['a'] = {
            'add',
            config = {
              show_path = 'none',
            },
          },
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['c'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['?'] = 'show_help',
          ['q'] = 'close_window',
        },
      },
      filesystem = {
        window = {
          mappings = {
            ['H'] = 'toggle_hidden',
            ['/'] = 'filter_on_submit',
            ['-'] = 'navigate_up',
            ['.'] = 'set_root',
            ['<Esc>'] = 'dynamic_cancel',
          },
        },
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
        find_args = {
          fd = {
            '--exclude',
            '.git',
            '--exclude',
            'node_modules',
            '--exclude',
            'bin',
            '--exclude',
            'obj',
          },
        },
        follow_current_file = {
          enabled = true,
        },
      },
    }
    vim.keymap.set('n', '<leader>e', '<cmd>Neotree<CR>', { desc = 'Focus tree explorer', silent = true })
    vim.keymap.set('n', '<leader>E', '<cmd>Neotree reveal<CR>', { desc = 'Focus tree explorer', silent = true })

    vim.api.nvim_create_autocmd('BufWinEnter', {
      pattern = '*',
      callback = function()
        if vim.bo.filetype == 'neo-tree' then
          vim.wo.foldcolumn = '0'
        end
      end,
    })
  end,
}
