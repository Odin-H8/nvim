return {
    {
        'stevearc/dressing.nvim',
        opts = {},
        config = function ()
            require('dressing').setup({
            })
        end
    },
    {
        'rcarriga/nvim-notify',
        config = function ()
            vim.notify = require("notify")
        end
    }
}
