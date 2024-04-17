return {
  'nvim-tree/nvim-tree.lua',
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

        local function map(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { desc = 'nvim-tree: ' .. desc, buffer = bufnr, silent = true, nowait = true })
        end
        api.config.mappings.default_on_attach(bufnr)
        map('<leader>e', '<C-w><C-p>', 'Switch previous window')
        map('.', api.tree.change_root_to_node, 'CD')
        map('<leader>i', api.node.show_info_popup, 'Show info')
        map('|', api.node.open.vertical, 'Open vertical split')
        map('/', api.node.open.horizontal, 'Open horizontal split')
        -- map('<BS>', api.node.navigate.parent_close, '')
        map('<CR>', api.node.open.edit, 'Open')
        map('-', api.tree.change_root_to_parent, '..')
        map('a', api.fs.create, 'Add file/folder')
        map('d', api.fs.remove, 'Delete')
        map('D', api.marks.bulk.delete, 'Bulk Delete')
        -- map('bmv', api.marks.bulk.move)
        -- map('c', api.fs.copy.node)
        -- map('C', api.tree.toggle_git_clean_filter)
        map('E', api.tree.expand_all, 'Expand All')
        map('r', api.fs.rename_basename, 'Rename')
        -- map(']e', api.node.navigate.diagnostics.next)
        -- map('[e', api.node.navigate.diagnostics.prev)
        -- map('F', api.live_filter.clear)
        -- map('f', api.live_filter.start)
        -- map('gy', api.fs.copy.absolute_path)
        -- map('ge', api.fs.copy.basename)
        -- map('H', api.tree.toggle_hidden_filter)
        -- map('I', api.tree.toggle_gitignore_filter)
        -- map('J', api.node.navigate.sibling.last)
        -- map('K', api.node.navigate.sibling.first)
        -- map('L', api.node.open.toggle_group_empty)
        -- map('M', api.tree.toggle_no_bookmark_filter)
        -- map('m', api.marks.toggle)
        -- map('o', api.node.open.edit)
        -- map('O', api.node.open.no_window_picker)
        -- map('p', api.fs.paste)
        -- map('P', api.node.navigate.parent)
        -- map('q', api.tree.close)
        map('R', api.fs.rename, 'Rename Full')
        -- map('R', api.tree.reload)
        -- map('s', api.node.run.system)
        -- map('S', api.tree.search_node)
        -- map('u', api.fs.rename_full)
        -- map('U', api.tree.toggle_custom_filter)
        -- map('W', api.tree.collapse_all)
        -- map('x', api.fs.cut)
        -- map('y', api.fs.copy.filename)
        -- map('Y', api.fs.copy.relative_path)
        -- map('<2-LeftMouse>', api.node.open.edit)
        -- map('<2-RightMouse>', api.tree.change_root_to_node)
        map('??', api.tree.toggle_help, 'Toggle help')
      end,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = true,
      sync_root_with_cwd = true,
      -- select_prompts = true,
    }

    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'Focus File Explorer' })
  end,
}
