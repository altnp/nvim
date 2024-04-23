return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-tree/nvim-web-devicons',
    'benfowler/telescope-luasnip.nvim',
    'debugloop/telescope-undo.nvim',
  },
  config = function()
    require('telescope').setup {
      defaults = {
        vimgrep_arguments = {
          'rg',
          '-L',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
        },
        prompt_prefix = '   ',
        selection_caret = '  ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        file_ignore_patterns = { 'node_modules' },
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        path_display = function(_, path)
          local tail = require('telescope.utils').path_tail(path)
          return string.format('%s (%s)', tail, path)
        end,
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        set_env = { ['COLORTERM'] = 'truecolor' },
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
        -- default_mappings = nil,
        mappings = {
          n = {
            ['q'] = require('telescope.actions').close,
            ['<Esc>'] = require('telescope.actions').close,
            ['<2-LeftMouse>'] = require('telescope.actions').double_mouse_click,
            ['<LeftMouse>'] = require('telescope.actions').mouse_click,
            ['j'] = require('telescope.actions').move_selection_next,
            ['J'] = function(prompt_bufnr)
              local actions = require 'telescope.actions'
              local action_state = require 'telescope.actions.state'
              local current_picker = action_state.get_current_picker(prompt_bufnr)
              local max_line = #current_picker.finder.results

              if current_picker:get_selection_row() <= max_line - 1 then
                local lines = require('math').min(max_line - current_picker:get_selection_row() - 1, 5)
                print(lines)
                for _ = 1, lines do
                  actions.move_selection_next(prompt_bufnr)
                end
              end
            end,
            ['k'] = require('telescope.actions').move_selection_previous,
            ['K'] = function(prompt_bufnr)
              local actions = require 'telescope.actions'
              local action_state = require 'telescope.actions.state'
              local current_picker = action_state.get_current_picker(prompt_bufnr)

              if current_picker:get_selection_row() > 0 then
                local lines = require('math').min(current_picker:get_selection_row(), 5)
                print(lines)
                for _ = 1, lines do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end
            end,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown { layout_config = { width = 0.5 } },
        },
        undo = {},
      },
    }

    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'ui-select'
    require('telescope').load_extension 'undo'
    require('telescope').load_extension 'luasnip'
  end,
}
