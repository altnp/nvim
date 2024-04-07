return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", mode = "n", desc = "Open Undotree" },
  },
  config = function(_, _) 
    local g = vim.g
    g.undotree_WindowLayout = 3
    g.undotree_SetFocusWhenToggle = 1
    g.undotree_HelpLine = 0

    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
  end
}
