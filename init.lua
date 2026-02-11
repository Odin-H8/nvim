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

function Do_file_if_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		dofile(name)
	end
end

local path = vim.fn.stdpath('config')
Do_file_if_exists(path .. "/plugin.lua")
Do_file_if_exists(path .. "/lsp.lua")
Do_file_if_exists(path .. "/keybinds.lua")

Do_file_if_exists(vim.env.HOME .. "/.local/share/nvim-config/overseer/other/dapconfig.lua")
Do_file_if_exists(vim.env.HOME .. "/.local/share/nvim-config/overseer/template/init.lua")

require("everforest").load()
