local opt = vim.opt
local o = vim.o
local g = vim.g

o.timeoutlen = 300
o.updatetime = 250
o.clipboard = 'unnamedplus'
o.termguicolors = true
vim.opt.undofile = true

-- Windows
o.scrolloff = 7
o.splitbelow = true
o.splitright = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Gutter
o.signcolumn = 'yes'
o.relativenumber = true
o.number = true
o.numberwidth = 2
opt.fillchars = { eob = ' ' }

-- Find and Replace
o.ignorecase = true
o.smartcase = true
opt.inccommand = 'split'

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

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

-- Providers
g['loaded_node_provider'] = 0
g['loaded_python3_provider'] = 0
g['loaded_perl_provider'] = 0
g['loaded_ruby_provider'] = 0
