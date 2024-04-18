local map = vim.keymap.set

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

-- Buffers
map('n', '<leader><tab>', '<C-^>', { desc = 'Switch tab' })
map('n', '<leader>n', '<cmd>enew<CR>', { desc = 'New File' })

-- telescope
map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>', { desc = 'Telescope Live grep' })
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'Telescope Find buffers' })
map('n', '<leader>fz', '<cmd>Telescope current_buffer_fuzzy_find<CR>', { desc = 'Telescope Find in current buffer' })
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Telescope Find files' })
map('n', '<leader>fa', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>', { desc = 'Telescope Find all files' })
map('n', '??', '<cmd>Telescope help_tags<cr>', { desc = 'Telescope Help Pages' })
map('n', '<leader>u', '<cmd>Telescope undo<cr>', { desc = 'Telescope Undo' })
-- vim.keymap.set('n', '<leader>pws', function()
--   local word = vim.fn.expand '<cword>'
--   require('telescope.builtin').grep_string { search = word }
-- end)
-- vim.keymap.set('n', '<leader>ps', function()
--   require('telescope.builtin').grep_string { search = vim.fn.input 'Grep > ' }
-- end)

-- blankline
map('n', '<leader>cc', function()
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
end, { desc = 'Blankline Jump to current context' })

-- Undo with U
map('n', 'U', '<C-r>', { silent = true })
map('n', 'u', 'u', { silent = true })

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
map('n', 'c*', '*``cgn', { desc = '' })
map('n', 'c#', '#``cgN', { desc = '' })

-- Insert blank lines
map('n', '<C-o>', "o<Esc>'[k")
map('n', '<C-S-o>', 'O<Esc>j', { desc = '' })

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

-- Buffer remaps

-- Enhanced visual mode selection
map('n', 'vv', 'V', { desc = '' })

-- Text transformation
map('n', 'gUiw', 'mzgUiw`z', { desc = '' })
map('n', 'guiw', 'mzguiw`z', { desc = '' })

-- Smart enter insert...
map('n', 'i', function()
  if vim.fn.getline('.'):match '^%s*$' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('"_cc', true, false, true), 'n', false)
  else
    vim.api.nvim_feedkeys('i', 'n', false)
  end
end)

map('n', '<M-z>', '<cmd>set wrap!<cr>', { desc = '' })

-- Mouse
map('v', '<RightMouse>', 'y', { desc = '' })
map('n', '<RightMouse>', 'y', { desc = '' })

-- Temp
map('n', '<leader>J', 'J', { desc = '' })
map('v', '<leader>J', 'J', { desc = '' })

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

-- Misc
map('n', '<leader>=', '`[v`]=')
map('n', '<Esc>', '<cmd>noh<CR>', { desc = 'General Clear highlights' })
