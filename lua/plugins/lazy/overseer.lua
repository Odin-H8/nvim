
return {
    'stevearc/overseer.nvim',
    opts = {},
    config = function ()
        require('overseer').setup({
            templates = { "builtin", "user.tunneler_run", "user.tunneler_agent3_run", "user.tunneler_agent4_run", "user.tunneler_gui", "user.tunneler_tests", "user.monitor4_syncer_run" },
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
