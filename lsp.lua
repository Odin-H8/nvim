vim.lsp.config("gopls", {
	on_attach = function (client)
		-- gopls semantic tokens render at higher priority than treesitter
		-- and recolor identifiers with a flatter palette, which looks like
		-- treesitter highlighting "turning off" ~1s after open. Disable them
		-- so treesitter highlighting stays.
		client.server_capabilities.semanticTokensProvider = nil
	end,
	settings = {
		gopls = {
			usePlaceholders = true,
			analyses = {
				shadow = true,
				unusedwrite = true,
				unusedvariable = true
			},
			staticcheck = true,
			gofumpt = true,
			hints = {
				assignVariableTypes = false,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				functionTypeParameters = true,
				parameterNames = true
			}
		}
	}
})

vim.lsp.enable({ "gopls", "asm_lsp", "emmylua_ls", "clangd", "vtsls", "html", "cssls" })

-- my first own autocmd!
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function ()
		vim.lsp.inlay_hint.enable()
	end
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'TSUpdate',
	callback = function ()
		require("nvim-treesitter.parsers").go = {
			install_info = {
				url = "https://github.com/alienvspredator/tree-sitter-go",
				branch = "main"
			}
		}
	end
})

-- On nvim-treesitter's `main` branch, setup() only accepts `install_dir`; the
-- old `ensure_installed`/`auto_install`/`highlight`/`indent` options are no-ops.
-- Parsers are installed via install(), and highlighting is started per-buffer in
-- the FileType autocmd below. (`lua` is the parser; `lua_ls` is the LSP server.)
require("nvim-treesitter").install({
	"go",
	"cpp",
	"c",
	"lua",
	"markdown_inline",
	"markdown",
	"html",
	"yaml"
})

vim.api.nvim_create_autocmd("FileType", { -- enable treesitter highlighting and indents
	callback = function (args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if lang == nil then
			return
		end

		-- parser already available: start highlighting immediately
		if vim.treesitter.language.add(lang) then
			-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- not working specifically for lua for some reason
			vim.treesitter.start(args.buf, lang)
			return
		end

		-- otherwise auto-install on demand, then start (replaces `auto_install`)
		local ts = require("nvim-treesitter")
		if vim.list_contains(ts.get_available(), lang) then
			ts.install({ lang }):await(function (err)
				if err then
					return
				end
				vim.schedule(function ()
					if vim.api.nvim_buf_is_valid(args.buf) then
						vim.treesitter.start(args.buf, lang)
					end
				end)
			end)
		end
	end
})

local diag = require("tiny-inline-diagnostic")

local methods = vim.lsp.protocol.Methods
local inlay_hint_handler = vim.lsp.handlers[methods["textDocument_inlayHint"]]
vim.lsp.handlers[methods["textDocument_inlayHint"]] = function (err, result, ctx, config)
	if type(result) ~= "table" and type(result) ~= "function" then
		return
	end

	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if client then
		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
		result = vim.iter(result)
			:filter(function (hint)
				return hint.position.line + 1 == row
			end)
			:totable()
	end
	inlay_hint_handler(err, result, ctx, config)

	-- The inlay-hint extmarks are only applied by core's decoration provider
	-- during a redraw. tiny-inline-diagnostic positions the cursor-line
	-- diagnostic at virtcol('$'), which only reflects those inline hints once
	-- they're drawn. So force the redraw first, then re-measure & re-render.
	vim.schedule(function ()
		local bufnr = ctx.bufnr
		if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
			vim.cmd("redraw")
			require("tiny-inline-diagnostic.renderer").safe_render(diag.config, bufnr)
		end
	end)
end

vim.o.updatetime = 250

-- onAttach
local inlay_hints_group = vim.api.nvim_create_augroup('LSP_inlayHints', { clear = false })
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
	group = inlay_hints_group,
	desc = 'Update inlay hints on line change',
	buffer = bufnr,
	callback = function ()
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
})

local blink_list = require("blink.cmp.completion.list")
local orig_fuzzy = blink_list.fuzzy
blink_list.fuzzy = function (context, items_by_source)
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
