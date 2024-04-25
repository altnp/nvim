local map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend('force', { silent = true }, opts or {}))
end

-- Escape mappings
map({ 'i', 'c' }, 'jj', '<Esc>', { desc = 'Exit mode' })

-- Buffer Navigation
map({ 'n', 'x', 'o' }, 'H', '^', { desc = 'Move to start of line' })
map({ 'n', 'x', 'o' }, 'L', '$', { desc = 'Move to end of line' })
map({ 'n', 'x' }, 'J', '10j', { desc = 'Move down 10 lines' })
map({ 'n', 'x' }, 'K', '10k', { desc = 'Move up 10 lines' })
map('n', '<M-h>', '<C-o>', { desc = 'Jump backwards' })
map('n', '<M-l>', '<C-i>', { desc = 'Jump forwards' })
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scoll up' })
map('i', '<C-BS>', '<C-w>', { desc = 'Delete word backwards' })

-- Windows
map('n', '<C-h>', '<C-w>h', { desc = 'Switch window left' })
map('n', '<C-l>', '<C-w>l', { desc = 'Switch window right' })
map('n', '<C-j>', '<C-w>j', { desc = 'Switch window down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Switch window up' })
map('n', '\\', '<Cmd>split<CR>', { desc = 'Split window horizontal' })
map('n', '|', '<Cmd>vsplit<CR>', { desc = 'Split window vertical' })
map('n', '<Left>', '<cmd>vertical resize -2<cr>', { desc = '' })
map('n', '<Right>', '<cmd>vertical resize +2<cr>', { desc = '' })
map('n', '<Down>', '<cmd>horizontal resize -2<cr>', { desc = '' })
map('n', '<Up>', '<cmd>horizontal resize +2<cr>', { desc = '' })

-- Buffers
map('n', '<leader><tab>', '<C-^>', { desc = 'Switch tab' })
map('n', '<leader>n', '<cmd>enew<CR>', { desc = 'New File' })

-- blankline
map('n', '<leader><leader>', function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require('ibl.scope').get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys('_', 'n', true)
    end
  end
end, { desc = 'Jump to current context' })

-- Undo with U
map('n', 'U', '<C-r>', { desc = 'Redo' })
map('n', 'u', 'u', { desc = 'Undo' })

-- Clipboard mappings
map('n', 'Y', 'y$', { desc = '' })
map('n', 'x', '"_x', { desc = '' })
map('n', 'X', '"_X', { desc = '' })
map('n', 'd', '"xd', { desc = '' })
map('n', 'dd', '"xdd', { desc = '' })
map('n', 'D', '"xD', { desc = '' })
map('n', 'c', '"xc', { desc = '' })
map('n', 'cc', '"xcc', { desc = '' })
map('n', 'C', '"xC', { desc = '' })
map('v', 'p', '"xdP', { desc = '' })

map('n', '<leader>p', '"xp', { desc = '' })
map('n', '<leader>P', '"xP', { desc = '' })
map('v', '<leader>p', '"xd"xP', { desc = '' })

-- Find and Replace
map('n', 'c*', '*``cgn', { desc = 'Change current word' })

-- Insert blank lines
map('n', '<CR>', 'o<Esc>', { desc = '' })
map('n', '<S-CR>', 'O<Esc>', { desc = '' })

-- Save and quit remaps
map('n', '<C-s>', '<cmd>silent up<cr>', { desc = '' })
map('n', '<C-S-s>', '<cmd>silent wa<cr>', { desc = '' })
map('i', '<C-s>', '<cmd>silent up<cr><Esc>', { desc = '' })
map('i', '<C-S-s>', '<cmd>silent wa<cr><Esc>', { desc = '' })
map('n', '<C-w>', '<cmd>confirm q<cr>', { desc = '' })
map('n', '<C-S-w>', '<cmd>confirm qa<cr>', { desc = '' })

-- No operation remaps
map('i', '<C-q>', '<nop>', { desc = '' })
map('n', '<C-q>', '<nop>', { desc = '' })
map('n', 'Q', '<nop>', { desc = '' })

-- Enhanced visual mode selection
map('n', 'vv', 'V', { desc = '' })

-- Text transformation
map('n', 'gUiw', 'mzgUiw`z', { desc = '' })
map('n', 'guiw', 'mzguiw`z', { desc = '' })

-- Smart enter insert...
-- NOTE: Feedkeys breaks macros so we have to do this goofy global function
vim.api.nvim_set_keymap('n', 'i', 'v:lua.SmartInsert()', { expr = true, noremap = true })

function _G.SmartInsert()
  if vim.fn.getline '.' == '' or vim.fn.getline('.'):match '^%s*$' then
    return '"_cc'
  else
    return 'i'
  end
end

map('n', '<M-z>', '<cmd>set wrap!<cr>', { desc = '' })

-- Mouse
map('v', '<RightMouse>', 'y', { desc = '' })
map('n', '<RightMouse>', 'y', { desc = '' })

-- Temp
map('n', '<leader>J', 'J', { desc = 'Join' })
map('x', '<leader>J', 'J', { desc = 'Join' })

map('i', '<S-Tab>', function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  if col > 0 then
    local line = vim.api.nvim_get_current_line()
    local char_before_cursor = line:sub(col, col)
    if char_before_cursor == ' ' then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<BS>', true, true, true), 'i', true)
    end
  end
end, { noremap = true, silent = true })

map('o', 'ae', '<Plug>(textobj-entire-a)``', { desc = '' })
map('o', 'ae', '<Plug>(textobj-entire-i)``', { desc = '' })
map('n', '<leader>a', 'v<Plug>(textobj-entire-a)', { desc = '' })

-- Misc
map('n', '<leader>=', '`[v`]=')
map('n', '<Esc>', '<cmd>noh<CR>', { desc = 'General Clear highlights' })
