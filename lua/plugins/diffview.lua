-- return {
--   'sindrets/diffview.nvim',
--   event = 'VeryLazy',
--   dependencies = {
--     'nvim-tree/nvim-web-devicons',
--   },
--   config = function()
--     require('diffview').setup()
--   end,
-- }
return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
