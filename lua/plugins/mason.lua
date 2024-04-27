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

      -- Override :Mason to load telescope for the filter menu, incase telescope has not been loaded yet
      vim.api.nvim_create_user_command('Mason', function()
        require 'telescope'
        require('mason.ui').open()
      end, {})
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
      local ensure_installed = vim.tbl_keys(require 'configs.lsp' or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })

      return {
        ensure_installed = ensure_installed,
        auto_update = true,
        -- start_delay = 1000,
        -- debounce_hours = 12,
      }
    end,
  },
}
