vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",          version = "main" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/mfussenegger/nvim-lint" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/mikavilpas/yazi.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/navarasu/onedark.nvim" },
	{ src = "https://github.com/stevearc/overseer.nvim" },
	{ src = "https://github.com/stevearc/dressing.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/Saghen/blink.cmp",                         version = "v1.6.0" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/echasnovski/mini.icons" },
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/igorlfs/nvim-dap-view" },
	{ src = "https://github.com/dmtrKovalenko/fff.nvim" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
	{ src = "https://github.com/tpope/vim-dadbod" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/neanias/everforest-nvim" },
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/zbirenbaum/copilot.lua" },
	{ src = "https://github.com/giuxtaposition/blink-cmp-copilot" }
})

vim.cmd("packadd nvim.undotree")

require "gitsigns".setup()
require "mason".setup()
require "bufferline".setup()
require "yazi".setup()
require "notify".setup()
require "flash".setup()

require "tiny-inline-diagnostic".setup({
	preset = "simple",
	transparent_bg = true,
	signs = {
		diag = "ඞ",
		left = "",
		right = "",
		arrow = "",
	}
})

require "nvim-autopairs".setup({
	disable_filetype = { "TelescopePrompt", "spectre_panel", "fff_input" },
})


require "fff".setup({
	keymaps = {
		move_up = { "<Tab>", "<Up>" },
		move_down = { "<S-tab>", "<Down>" },
		toggle_select = { },
		cycle_grep_modes = '<C-f>',
	}
})

require "render-markdown".setup({
	completions = { blink = { enabled = true } },
})

local lint = require("lint")
lint.linters_by_ft = {
	go = { "golangcilint" },
}

vim.keymap.set("n", "<leader>ii", function() lint.try_lint() end)

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

require "overseer".setup({
	templates = { "builtin" },
	strategy = "terminal",
	log = {
		{
			type = "notify",
			level = vim.log.levels.WARN,
		},
		{
			type = "file",
			filename = "overseer.log",
			level = vim.log.levels.WARN,
		},
	},
})

require "blink.cmp".setup({
	keymap = {
		['<Tab>']   = { 'select_next', 'fallback' },
		['<S-Tab>'] = { 'select_prev', 'fallback' },
		['<CR>']    = { 'accept', 'fallback' },
		['<C-f>']   = { 'snippet_forward', 'fallback' },
		['<C-b>']   = { 'snippet_backward', 'fallback' },
		['<C-d>']   = { 'scroll_documentation_down', 'fallback' },
		['<C-u>']   = { 'scroll_documentation_up', 'fallback' },
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
		},
		menu = {
			auto_show = true
		},
		list = {
			selection = {
				preselect = false
			}
		},
	},
	cmdline = {
		keymap = { preset = 'inherit' },
		completion = { menu = { auto_show = true }, list = { selection = { preselect = false } } },
	},
	signature = {
		enabled = true,
		trigger = {
			enabled = true,
			show_on_insert = true,
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer", "copilot" },
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-cmp-copilot",
				score_offset = -1000,
				async = true,
			},
		},
	},
})

require "conform".setup({
	formatters_by_ft = {
		go = { "goimports", "gofmt" },
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
})


-- require "dap-view".setup({
-- 	winbar = {
-- 		sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
-- 	}
-- })


require('copilot').setup({
	suggestion = { enabled = false },
})
