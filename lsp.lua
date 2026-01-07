vim.lsp.config('copilot', {
	cmd = { 'copilot-language-server', '--stdio', },
	root_markers = { '.git' },
})

vim.lsp.enable({ "gopls", "lua_ls", "clangd", "copilot" })

require 'nvim-treesitter.config'.setup({
	ensure_installed = { 'go', 'cpp', 'c', 'lua_ls', "markdown_inline", "markdown", "html", "yaml" },
	auto_install = true,
	highlight = { enable = true, },
	indent = {
		enable = true,
	}
})

local lsp = require "lspconfig"

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
