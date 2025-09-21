vim.opt.compatible = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.ruler = true
vim.opt.ai = true
vim.opt.wildmenu = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.path = vim.opt.path + "**"
vim.opt.backspace = [[indent,eol,start]]
vim.opt.mouse = 'a'
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.listchars = [[tab:» ,trail:·]]
vim.opt.list = true
vim.opt.colorcolumn = '81'
vim.opt.runtimepath = vim.opt.runtimepath + '~/.config/nvim/lua'
vim.opt.runtimepath = vim.opt.runtimepath + (vim.fn.stdpath('data') .. '/lazy/lazy.nvim')

require('autocmds')
require('plugins')
require('keys')

if vim.uv.fs_stat(vim.fn.stdpath('config') .. '/lua/per_system.lua') then
    require('per_system')
end
