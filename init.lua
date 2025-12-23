vim.o.relativenumber = true
vim.o.number = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.scrolloff = 7
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.hlsearch = false

vim.g.mapleader = ","

local path = vim.fn.stdpath('config')
dofile(path .. "/plugin.lua")
dofile(path .. "/lsp.lua")
dofile(path .. "/keybinds.lua")
--dofile(path .. "/lua/overseer/other/dapconfig.lua")


require("everforest").load()
