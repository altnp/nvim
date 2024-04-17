local M = {}

M.get_keymap = function(mode, lhs)
  local keymaps = vim.api.nvim_get_keymap(mode)
  for _, map in ipairs(keymaps) do
    if map.lhs == lhs then
      return map
    end
  end
  return nil
end

return M
