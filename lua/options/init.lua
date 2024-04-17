local autocmd = vim.api.nvim_create_autocmd
local opts_group = vim.api.nvim_create_augroup('Options', { clear = true })

local opt = vim.opt
local o = vim.o
local g = vim.g

o.timeoutlen = 500
o.updatetime = 1000
o.clipboard = 'unnamedplus'
o.termguicolors = true
opt.undofile = true

autocmd('FileType', {
  group = opts_group,
  callback = function()
    opt.formatoptions:remove 'o'
  end,
})

-- Windows
o.scrolloff = 7
o.splitbelow = true
o.splitright = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.showbreak = '󱞩'

-- Completion
opt.pumheight = 6

-- Gutter
o.signcolumn = 'yes'
o.relativenumber = true
o.number = true
o.numberwidth = 2
opt.fillchars = { eob = ' ' }

-- Find and Replace
o.ignorecase = true
o.smartcase = true
opt.inccommand = 'nosplit'

-- Cursor
o.cursorline = true
o.cursorlineopt = 'both'
o.guicursor = o.guicursor .. ',a:blinkon100'
o.mouse = 'a'
opt.whichwrap:append '<>[]hl'

-- Status Line
o.laststatus = 3
o.showmode = true -- false
o.ruler = false
o.showcmd = true

-- Indenting
o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4

-- Providers
g['loaded_node_provider'] = 0
g['loaded_python3_provider'] = 0
g['loaded_perl_provider'] = 0
g['loaded_ruby_provider'] = 0

local is_windows = vim.fn.has 'win32' ~= 0
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin' .. (is_windows and ';' or ':') .. vim.env.PATH
