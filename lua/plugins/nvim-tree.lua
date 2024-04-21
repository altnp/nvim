-- Currently disabled in favor of neo-tree
return {
  'nvim-tree/nvim-tree.lua',
  enabled = false,
  keys = {
    { '<leader>e', mode = 'n', desc = 'Focus File Explorer' },
  },
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'Mofiqul/vscode.nvim',
  },
  config = function()
    require('nvim-tree').setup {
      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'

        -- api.config.mappings.default_on_attach(bufnr)

        local function map(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { desc = 'nvim-tree: ' .. desc, buffer = bufnr, silent = true, nowait = true })
        end
        map('<leader>e', '<C-w><C-p>', 'Switch previous window')
        map('.', api.tree.change_root_to_node, 'CD')
        map('<leader>i', api.node.show_info_popup, 'Show info')
        map('|', api.node.open.vertical, 'Open vertical split')
        map('\\', api.node.open.horizontal, 'Open horizontal split')
        map('<BS>', api.node.navigate.parent_close, 'Close folder')
        map('<CR>', api.node.open.edit, 'Open')
        map('<Tab>', api.node.open.preview, 'Open preview')
        map('-', api.tree.change_root_to_parent, '..')
        map('a', api.fs.create, 'Add file/folder')
        map('d', api.fs.remove, 'Delete')
        map('D', api.marks.bulk.delete, 'Bulk delete')
        map('B', api.marks.bulk.move, 'Bulk move')
        map('c', api.fs.copy.node, 'Copy')
        map('x', api.fs.cut, 'Cut')
        map('p', api.fs.paste, 'Paste')
        map('E', api.tree.expand_all, 'Expand all')
        map('r', api.fs.rename_basename, 'Rename')
        map('R', api.fs.rename, 'Rename file')
        map('rr', api.fs.rename_full, 'Rename full')
        map('b', api.marks.toggle, 'Mark')

        -- map('C', api.tree.toggle_git_clean_filter)
        map('<leader>h', api.tree.toggle_hidden_filter, 'Toggle hidden items')
        map('<leader>g', api.tree.toggle_gitignore_filter, 'Toggle git items')
        map('<leader>m', api.tree.toggle_no_bookmark_filter, 'Toggle marked items')
        map('<leader>e', api.node.open.toggle_group_empty, 'Toggle emty groups')
        map('q', api.tree.close, 'Close')
        map('W', api.tree.collapse_all, 'Collapse all')
        map('y', api.fs.copy.filename, 'Yank filename')
        map('yy', api.fs.copy.basename, 'Yank filename (no ext)')
        map('Y', api.fs.copy.relative_path, 'Yank relative path')
        map('gy', api.fs.copy.absolute_path, 'Yank full path')
        map('<2-LeftMouse>', api.node.open.edit, 'Open')
        map('??', api.tree.toggle_help, 'Toggle help')

        -- Esc to clear filter or / search
        local filterActive = false
        map('f', function()
          filterActive = true
          api.live_filter.start()
        end, 'Filter')
        local escFallback = require('utils').get_keymap('n', '<Esc>')
        map('<Esc>', function()
          if filterActive then
            filterActive = false
            api.live_filter.clear()
          else
            if escFallback then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(escFallback.rhs, true, true, true), 'n', true)
            end
          end
        end, 'Clear filter')
        map('J', api.node.navigate.sibling.last, 'Move to last item')
        map('K', api.node.navigate.sibling.first, 'Move to first item')
      end,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = true,
      sync_root_with_cwd = true,
      renderer = {
        group_empty = true,
      },
    }

    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'Focus File Explorer' })
  end,
}
