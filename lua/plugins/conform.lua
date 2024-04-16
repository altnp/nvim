return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  keys = {
    { '<leader>fm', mode = 'n', desc = 'Format File' },
  },
  opts = {
    notify_on_error = true,
    formatters_by_ft = {
      lua = { 'stylua' },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)

    vim.keymap.set('n', '<leader>fm', function()
      require('conform').format { lsp_fallback = true }
    end, { desc = 'Format File' })

    -- Autoformat
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('Autoformat', { clear = true }),
      pattern = { '*.lua' },
      callback = function(args)
        require('conform').format {
          bufnr = args.buf,
          timeout_ms = 500,
          lsp_fallback = true,
          quiet = true,
        }
      end,
    })
  end,
}
