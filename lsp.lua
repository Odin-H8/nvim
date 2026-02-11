vim.lsp.config('copilot', {
	cmd = { 'copilot-language-server', '--stdio', },
	root_markers = { '.git' },
})

local lsp = require "lspconfig"

lsp.gopls.setup({
	settings = {
		gopls = {
			analyses = {
				shadow = true,
				unusedwrite = true,
				unusedvariable = true,
			},
			staticcheck = true,
			gofumpt = true,
			hints = {
				assignVariableTypes = false,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				functionTypeParameters = true,
				parameterNames = true,
			},
		},
	},
})

vim.lsp.enable({ "lua_ls", "clangd", "copilot", "asm_lsp" })

-- my first own autocmd!
vim.api.nvim_create_autocmd({ "BufEnter", }, {
	callback = function()
		vim.lsp.inlay_hint.enable()
	end,
})

require 'nvim-treesitter.config'.setup({
	ensure_installed = { 'go', 'cpp', 'c', 'lua_ls', "markdown_inline", "markdown", "html", "yaml" },
	auto_install = true,
	highlight = { enable = true, },
	indent = {
		enable = true,
	}
})

vim.api.nvim_create_autocmd("FileType", { -- enable treesitter highlighting and indents
	callback = function(args)
		local filetype = args.match

		local lang = vim.treesitter.language.get_lang(filetype)

		if lang ~= nil and vim.treesitter.language.add(lang) then
			--		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- not working specifically for lua for some reason

			vim.treesitter.start()
		end
	end

})
