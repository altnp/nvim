return {
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
    opts = {
      PATH = 'skip',
      max_concurrent_installers = 10,
      ui = {
        icons = {
          package_pending = '',
          package_installed = '󰄳',
          package_uninstalled = '',
        },
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    lazy = false,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    opts = function()
      local ensure_installed = vim.tbl_keys(require 'configs.lsp-servers' or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })

      return {
        ensure_installed = ensure_installed,
        auto_update = true,
        start_delay = 1000,
        debounce_hours = 12,
      }
    end,
  },
}
