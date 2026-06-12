vim.lsp.config("gopls", {
	settings = {
		gopls = {
			usePlaceholders = true,
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

vim.lsp.enable({ "gopls", "asm_lsp", "lua_ls", "clangd", "vtsls", "html", "cssls" })

-- my first own autocmd!
vim.api.nvim_create_autocmd({ "BufEnter", }, {
	callback = function()
		vim.lsp.inlay_hint.enable()
	end,
})

vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
	callback = function () 
		require("nvim-treesitter.parsers").go = {
			install_info = {
				url = "https://github.com/alienvspredator/tree-sitter-go",
				branch = "main",
			},
		}
	end
})

require 'nvim-treesitter.config'.setup({
	ensure_installed = { 'cpp', 'c', 'lua_ls', "markdown_inline", "markdown", "html", "yaml" },
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

local methods = vim.lsp.protocol.Methods
local inlay_hint_handler = vim.lsp.handlers[methods["textDocument_inlayHint"]]
vim.lsp.handlers[methods["textDocument_inlayHint"]] = function(err, result, ctx, config)
	if type(result) ~= "table" and type(result) ~= "function" then
		return
	end

	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if client then
		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
		result = vim.iter(result)
			:filter(function(hint)
				return hint.position.line + 1 == row
			end)
			:totable()
	end
	inlay_hint_handler(err, result, ctx, config)
end

vim.o.updatetime = 250

-- onAttach
local inlay_hints_group = vim.api.nvim_create_augroup('LSP_inlayHints', { clear = false })
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
	group = inlay_hints_group,
	desc = 'Update inlay hints on line change',
	buffer = bufnr,
	callback = function()
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end,
})

local blink_list = require("blink.cmp.completion.list")
local orig_fuzzy = blink_list.fuzzy
blink_list.fuzzy = function(context, items_by_source)
    local items = orig_fuzzy(context, items_by_source)
    for i, item in ipairs(items) do
        if item.source_id == "copilot" then
            if i ~= 2 and #items > 1 then
                table.remove(items, i)
                table.insert(items, math.min(2, #items + 1), item)
            end
            break
        end
    end
    return items
end
