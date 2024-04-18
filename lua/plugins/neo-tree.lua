return {
  'nvim-neo-tree/neo-tree.nvim',
  event = 'VeryLazy',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      enable_modified_markers = false,
      enable_opened_markers = false,
      enable_cursor_hijack = true,
      hit_root_node = true,
      popup_border_style = 'rounded',
      sort_case_insensitive = true,
      window = {},
      filesystel = {
        hijack_netrw_behavior = 'open_current',
      },
    }
    vim.keymap.set('n', '<leader>e', '<cmd>Neotree<CR>', { desc = 'Focus tree explorer', silent = true })
    vim.keymap.set('n', '<leader>E', '<cmd>Neotree reveal<CR>', { desc = 'Focus tree explorer', silent = true })
  end,
}
