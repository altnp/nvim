return {
  'numToStr/Comment.nvim',
  keys = {
    { 'gcc', mode = 'n', desc = 'Comment toggle current line' },
    { 'gc', mode = { 'n', 'o' }, desc = 'Comment toggle linewise' },
    { 'gc', mode = 'x', desc = 'Comment toggle linewise (visual)' },
    { 'gbc', mode = 'n', desc = 'Comment toggle current block' },
    { 'gb', mode = { 'n', 'o' }, desc = 'Comment toggle blockwise' },
    { 'gb', mode = 'x', desc = 'Comment toggle blockwise (visual)' },
    { '<C-_>', mode = { 'n', 'x' }, desc = 'Comment toggle' }, --- VIM interprets ^/ -> ^_
  },
  config = function(_, opts)
    require('Comment').setup(opts)

    vim.keymap.set('n', '<C-_>', function()
      require('Comment.api').toggle.linewise.current()
    end, { desc = 'Comment toggle' })

    vim.keymap.set('x', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Comment Toggle' })
  end,
}
