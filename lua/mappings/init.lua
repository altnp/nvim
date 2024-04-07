local map = vim.keymap.set

-- Escape mappings
map("c", "jj", "<Esc>")

-- Buffer Navigation
map("n", "H", "^")
map("i", "jj", "<Esc>")
map("n", "L", "$")
map("n", "<Leader>j", "J")
map("n", "J", "10j")
map("n", "K", "10k")
map("n", "<M-h>", "<C-o>")
map("n", "<M-l>", "<C-i>")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("o", "H", "^")
map("o", "L", "$")
map("v", "J", "10j")
map("v", "K", "10k")
map("i", "<C-h>", "<Left>", { desc = "Move Left" })
map("i", "<C-l>", "<Right>", { desc = "Move Right" })
map("i", "<C-j>", "<Down>", { desc = "Move Down" })
map("i", "<C-k>", "<Up>", { desc = "Move Up" })
map("i", "<C-S-h>", "<C-o>^")
map("i", "<C-S-l>", "<C-o>$")

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Switch Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch Window up" })

map("n", "\\", "<Cmd>split<CR>", { desc = "Horizontal Split" })
map("n", "|", "<Cmd>vsplit<CR>", { desc = "Vertical Split" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })

-- Format File
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format File" })
map("n", "<leader>n", "<cmd>enew<CR>", { desc = "New File" })

-- global lsp mappings
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "Lsp floating diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Lsp prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Lsp next diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Lsp diagnostic loclist" })

-- Buffers
map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Buffer Goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Buffer Goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer Close" })

map("n", "<leader><tab>", "<C-^>")

-- Comment
map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Comment Toggle" })

map(
  "v",
  "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Comment Toggle" }
)

-- nvimtree
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Nvimtree Focus window" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Help page" })

map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope Find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope Git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "Telescope Pick hidden term" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "Telescope Nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Telescope Find all files" }
)

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "Blankline Jump to current context" })

-- Select Whole Buffer
map("n", "<leader>a", "GVgg")

-- Undo with U
map("n", "U", "<C-r>")

-- Clipboard mappings
map("n", "Y", "y$")
map("n", "x", "\"_x")
map("n", "s", "\"_s")
map("n", "<leader>p", "\"0p")
map("n", "<leader>P", "\"0P")
map("v", "p", "\"_dP")
map("v", "<leader>p", "\"_d\"0P")

-- Find and Replace
map("n", "c*", "*``cgn")
map("n", "c#", "#``cgN")

-- Insert blank lines
map("n", "<C-o>", "o<Esc>'[k")
map("n", "<C-S-o>", "O<Esc>j")

-- Save and quit remaps
map("n", "<leader>w", "<cmd>up<cr>", { silent = true })
map("n", "<leader>W", "<cmd>wa<cr>", { silent = true })
map("n", "<leader>q", "<cmd>confirm q<cr>")
map("n", "<leader>Q", "<cmd>confirm qa<cr>")

-- No operation remaps
map("i", "<C-q>", "<nop>")
map("n", "Q", "<nop>")

-- Buffer remaps

-- Enhanced visual mode selection
map("n", "vv", "V")

-- Text transformation
map("n", "gUiw", "mzgUiw`z")
map("n", "guiw", "mzguiw`z")

-- Smart enter insert...
map("n", "i", function()
  if vim.fn.getline('.') == '' then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('"_cc', true, false, true), 'n', false)
  else
    vim.api.nvim_feedkeys('i', 'n', false)
  end
end)

map("n", "<M-z>", "<cmd>set wrap!<cr>")


