return {
  {
    'neovim/nvim-lspconfig',
    event = 'User FilePost',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          vim.lsp.buf_get_clients(event.buf)
          -- TODO: Update descriptions, move the "global" maps out of LspAttach?
          map('<leader>lf', vim.diagnostic.open_float, 'Lsp floating diagnostics')
          map('[d', vim.diagnostic.goto_prev, 'Lsp prev diagnostic')
          map(']d', vim.diagnostic.goto_next, 'Lsp next diagnostic')
          map('<leader>q', vim.diagnostic.setloclist, 'Lsp diagnostic loclist')

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- vim.keymap.set('i', '<C-h>', function()
          --   vim.lsp.buf.signature_help()
          -- end, opts)
          -- TODO: Map Key?
          -- map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- Hilight current token when cursor is inactive foro {updatetime}
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      -- capabilities.textDocument.completion.completionItem.snippetSupport = false

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = require('configs.lsp-servers')[server_name] or {}

            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  'hoffs/omnisharp-extended-lsp.nvim',
}
