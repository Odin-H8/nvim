return {
    {
        'mfussenegger/nvim-dap',
        config = function ()
            local dap = require("dap")
            -- create file with dap configuration
            InitDap()

            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<leader>ds", "<cmd> DapNew <CR>")

        end
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function ()
            local dapui = require('dapui')
            dapui.setup()

            vim.keymap.set("n", "<leader>db", dapui.toggle)
        end
    }
}
