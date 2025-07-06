
return {
    'stevearc/overseer.nvim',
    opts = {},
    config = function ()
        require('overseer').setup({
            templates = { "builtin", "user.init" },
            strategy="terminal",
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

        vim.keymap.set("n", "<leader>oo", "<Cmd> OverseerToggle <CR>")
        vim.keymap.set("n", "<leader>or", "<Cmd> OverseerRun <CR>")
    end,
    lazy = false,
}
