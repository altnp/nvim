local autocmd = vim.api.nvim_create_autocmd
local opts_group = vim.api.nvim_create_augroup('Options', { clear = true })

local opt = vim.opt
local g = vim.g

opt.timeoutlen = 500
opt.updatetime = 1000
opt.clipboard = 'unnamedplus'
opt.termguicolors = true
opt.undofile = true

autocmd('FileType', {
  group = opts_group,
  callback = function()
    opt.formatoptions:remove 'o'
  end,
})

-- Windows
opt.scrolloff = 7
opt.splitbelow = true
opt.splitright = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.showbreak = '󱞩'

-- Completion
opt.pumheight = 6

-- Gutter
opt.signcolumn = 'yes'
opt.relativenumber = true
opt.number = true
opt.numberwidth = 2
opt.foldcolumn = '1'
opt.fillchars = { eob = ' ', fold = ' ', foldopen = '󰅀', foldsep = ' ', foldclose = '' }
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Find and Replace
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'

-- Cursor
opt.cursorline = true
opt.cursorlineopt = 'both'
vim.o.guicursor = vim.o.guicursor .. ',a:blinkon100'
opt.mouse = 'a'
opt.whichwrap:append '<>[]hl'
opt.wrap = false

-- Status Line
opt.laststatus = 3
opt.showmode = true -- false
opt.ruler = false
opt.showcmd = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

-- Providers
g['loaded_node_provider'] = 0
g['loaded_python3_provider'] = 0
g['loaded_perl_provider'] = 0
g['loaded_ruby_provider'] = 0

local is_windows = vim.fn.has 'win32' ~= 0
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin' .. (is_windows and ';' or ':') .. vim.env.PATH
