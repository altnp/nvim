return {
  'williamboman/mason.nvim',
  cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
  opts = {
    PATH = 'skip',
    max_concurrent_installers = 10,
    ui = {
      icons = {
        package_pending = '',
        package_installed = '󰄳',
        package_uninstalled = ''
      }
    }
  },
  config = function(_, opts)
    require('mason').setup(opts)
  end
}
