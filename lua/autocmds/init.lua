local autocmd = vim.api.nvim_create_autocmd

-- Undofile Warning
local undofilegroup = vim.api.nvim_create_augroup('UndoFileWarning', { clear = true })
autocmd('BufEnter', {
  group = undofilegroup,
  desc = 'Undofile Warning - Track undofile seq when opening a buffer',
  callback = function()
    vim.b.seq_num_at_buffer_enter = vim.fn.undotree().seq_cur
    vim.b.has_warned_undo_past_enter = false
  end,
})

autocmd('TextChanged', {
  group = undofilegroup,
  desc = 'Unfofile Warning - Notify if undofile was used',
  callback = function()
    local seq_at_enter = vim.b.seq_num_at_buffer_enter or 0
    local current_seq = vim.fn.undotree().seq_cur
    if current_seq < seq_at_enter and not vim.b.has_warned_undo_past_enter then
      vim.notify('Undoing changes made before this buffer was opened.', vim.log.levels.WARN)
      vim.b.has_warned_undo_past_enter = true
    elseif current_seq >= seq_at_enter and vim.b.has_warned_undo_past_enter then
      vim.b.has_warned_undo_past_enter = false
    end
  end,
})

-- Highlihght on Yank
autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
  desc = 'Highlight yanked text',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      -- higroup = 'IncSearch',
      timeout = 75,
    }
  end,
})

-- Close panels with q
autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('ClosePannels', { clear = true }),
  desc = 'Close panels with q',
  callback = function(event)
    if vim.tbl_contains({ 'help', 'nofile', 'quickfix' }, vim.bo[event.buf].buftype) then
      vim.keymap.set('n', 'q', '<Cmd>close<CR>', {
        desc = 'Close window',
        buffer = event.buf,
        silent = true,
        nowait = true,
      })
    end
  end,
})

-- Custom Event for when Buffer Opened into Window, from NvChad
vim.api.nvim_create_autocmd({ 'UIEnter', 'BufReadPost', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('NvFilePost', { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_buf_get_option(args.buf, 'buftype')

    if not vim.g.ui_entered and args.event == 'UIEnter' then
      vim.g.ui_entered = true
    end

    if file ~= '' and buftype ~= 'nofile' and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds('User', { pattern = 'FilePost', modeline = false })
      vim.api.nvim_del_augroup_by_name 'NvFilePost'

      vim.schedule(function()
        vim.api.nvim_exec_autocmds('FileType', {})

        if vim.g.editorconfig then
          require('editorconfig').config(args.buf)
        end
      end)
    end
  end,
})
