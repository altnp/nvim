local autocmd = vim.api.nvim_create_autocmd

-- Undofile Warning
autocmd('BufEnter', {
  desc = 'Undofile Warning - Track undofile seq when opening a buffer',
  callback = function()
    vim.b.seq_num_at_buffer_enter = vim.fn.undotree().seq_cur
    vim.b.has_warned_undo_past_enter = false
  end
})

autocmd('TextChanged', {
  desc = 'Unfofile Warning - Notify if undofile was used',
  callback = function()
    local seq_at_enter = vim.b.seq_num_at_buffer_enter or 0
    local current_seq = vim.fn.undotree().seq_cur
    if current_seq < seq_at_enter and not vim.b.has_warned_undo_past_enter then
      vim.notify('Warning: Undoing changes made before this buffer was opened.', vim.log.levels.WARN)
      vim.b.has_warned_undo_past_enter = true
    elseif current_seq >= seq_at_enter and vim.b.has_warned_undo_past_enter then
      vim.b.has_warned_undo_past_enter = false
    end
  end
})

-- Highlihght on Yank
autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      -- higroup = 'IncSearch',
      timeout = 75,
    })
  end,
})

-- Close panels with q
autocmd('BufWinEnter', {
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
  end
})
