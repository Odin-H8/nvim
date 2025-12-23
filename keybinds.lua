local map = vim.keymap.set

map("n", "<leader>s", ":update<CR> :source<CR>")
map("n", "<leader>w", ":write<CR>")

map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")

vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })

map("n", "<leader>di", vim.diagnostic.open_float)


map('n', '<leader>ff', require("fff").find_files)

map('n', '<leader>fg', ":Telescope live_grep<CR>")
map('n', '<leader>fd', ":Telescope lsp_definitions<CR>")
map('n', '<leader>fr', ":Telescope lsp_references<CR>")
map('n', '<leader>fi', ":Telescope lsp_implementations<CR>")
map('n', '<leader>fe', ":Telescope diagnostics<CR>")
map('n', '<leader>rn', vim.lsp.buf.rename)

map('n', '<leader>n', ":NvimTreeToggle<CR>")

map('n', '<leader>cr', ":BufferLineCloseRight <CR>")
map('n', '<leader>cl', ":BufferLineCloseLeft <CR>")
map('n', '<leader>ca', ":BufferLineCloseOthers <CR>")
map('n', '<leader>cc', ":BufferLinePickClose <CR>")

map({ 'n', 'i' }, '<C-.>', "<cmd>BufferLineCycleNext<CR>")
map({ 'n', 'i' }, '<C-,>', "<cmd>BufferLineCyclePrev<CR>")

map('n', '<leader>1', ":BufferLineGoToBuffer 1 <CR>")
map('n', '<leader>2', ":BufferLineGoToBuffer 2 <CR>")
map('n', '<leader>3', ":BufferLineGoToBuffer 3 <CR>")
map('n', '<leader>4', ":BufferLineGoToBuffer 4 <CR>")
map('n', '<leader>5', ":BufferLineGoToBuffer 5 <CR>")
map('n', '<leader>6', ":BufferLineGoToBuffer 6 <CR>")
map('n', '<leader>7', ":BufferLineGoToBuffer 7 <CR>")
map('n', '<leader>8', ":BufferLineGoToBuffer 8 <CR>")
map('n', '<leader>9', ":BufferLineGoToBuffer 9 <CR>")

map("n", "S", function() vim.lsp.buf.definition() end, opts)
map("n", "X", function() vim.lsp.buf.type_definition() end, opts)
map("n", "Z", "<C-o>")
map("n", "K", function() vim.lsp.buf.hover() end, opts)


map("n", "<leader>lf", vim.lsp.buf.format)

map("n", "<leader>oo", ":OverseerToggle <CR>")
map("n", "<leader>or", ":OverseerRun <CR>")

map("n", "<leader>dd", ":DapViewToggle<CR>")

local dap = require "dap"
map("n", "<F1>", dap.continue)
map("n", "<F2>", dap.step_into)
map("n", "<leader>b", dap.toggle_breakpoint)
map("n", "<leader>ds", ":DapNew<CR>")

local flash = require "flash"
map({ "n", "x" }, "<leader>g", flash.jump)

map("n", "<leader>db", ":DBUIToggle <CR>")

vim.keymap.set("n", "<leader>qd", function()
	vim.diagnostic.setqflist({
		open = true,
		title = "Diagnostics",                                                  -- Optional: Gives your diagnostic list a clear title
		severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN }, -- Filter for errors/warnings
	})
end, { desc = "Populate Quickfix with Diagnostics" })
