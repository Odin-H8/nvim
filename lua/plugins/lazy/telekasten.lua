return {
    {
        'renerocksai/telekasten.nvim',
        dependencies = {'nvim-telescope/telescope.nvim'},

        config = function ()
            require('telekasten').setup({
                home = vim.fn.expand("~/notes"),
            })
            vim.keymap.set('n', '<leader>z', "<Cmd>Telekasten panel<CR>")

            vim.keymap.set('n', '<leader>zf', "<Cmd>Telekasten find_notes<CR>")
            vim.keymap.set('n', '<leader>zg', "<Cmd>Telekasten search_notes<CR>")
            vim.keymap.set('n', '<leader>zd', "<Cmd>Telekasten goto_today<CR>")
            vim.keymap.set('n', '<leader>zn', "<Cmd>Telekasten new_note<CR>")

        end
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function ()
            local peek = require('peek')
            peek.setup({
                auto_load = true,         -- whether to automatically load preview when
                -- entering another markdown buffer
                close_on_bdelete = true,  -- close preview window on buffer delete

                syntax = true,            -- enable syntax highlighting, affects performance

                theme = 'dark',           -- 'dark' or 'light'

                update_on_change = true,

                app = 'webview',          -- 'webview', 'browser', string or a table of strings
                -- explained below

                filetype = { 'markdown', 'telekasten' },-- list of filetypes to recognize as markdown

                -- relevant if update_on_change is true
                throttle_at = 200000,     -- start throttling when file exceeds this
                -- amount of bytes in size
                throttle_time = 'auto',   -- minimum amount of time in milliseconds
                -- that has to pass before starting new render
           })
            vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
            vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
        end
    }
}
