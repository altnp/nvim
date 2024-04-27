return {
  'lewis6991/gitsigns.nvim',
  event = 'User FilePost',
  config = function()
    require('gitsigns').setup {
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      signs = {
        changedelete = { text = '┃' },
      },
      preview_config = {
        border = {
          '╭',
          '─',
          '╮',
          '│',
          '╯',
          '─',
          '╰',
          '│',
        },
      },
    }
    vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
  end,
}
