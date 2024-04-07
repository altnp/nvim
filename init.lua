vim.g.base46_cache = vim.fn.stdpath 'data' .. '/nvchad/base46/'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'mappings'
require 'options'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local lazyconfig = {
  defaults = { lazy = true },
  ui = {
    icons = {
      ft = '',
      lazy = '󰂠 ',
      loaded = '',
      not_loaded = '',
    }
  }
}

require('lazy').setup({
  { import = 'plugins' }
}, lazyconfig)

require 'autocmds'
