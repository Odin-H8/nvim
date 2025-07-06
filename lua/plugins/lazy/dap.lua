return {
    {
        'mfussenegger/nvim-dap',
        config = function ()
            local dap = require("dap")
            -- create file with dap configuration, gitignored in case of secrets
            local path = vim.fn.stdpath("config")
            dofile(path .. "/lua/overseer/other/dapconfig.lua")

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
    },
    {
        'leoluz/nvim-dap-go',
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap",
        },
        config = function ()
            local dapGo = require('dap-go')
            dapGo.setup({
                dap_configurations = {
                    {
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                    },
                },
                delve = {
                    -- the path to the executable dlv which will be used for debugging.
                    -- by default, this is the "dlv" executable on your PATH.
                    path = "dlv",
                    -- time to wait for delve to initialize the debug session.
                    -- default to 20 seconds
                    initialize_timeout_sec = 20,
                    -- a string that defines the port to start delve debugger.
                    -- default to string "${port}" which instructs nvim-dap
                    -- to start the process in a random available port.
                    -- if you set a port in your debug configuration, its value will be
                    -- assigned dynamically.
                    port = "${port}",
                    -- additional args to pass to dlv
                    args = {},
                    -- the build flags that are passed to delve.
                    -- defaults to empty string, but can be used to provide flags
                    -- such as "-tags=unit" to make sure the test suite is
                    -- compiled during debugging, for example.
                    -- passing build flags using args is ineffective, as those are
                    -- ignored by delve in dap mode.
                    -- avaliable ui interactive function to prompt for arguments get_arguments
                    build_flags = {},
                    -- whether the dlv process to be created detached or not. there is
                    -- an issue on delve versions < 1.24.0 for Windows where this needs to be
                    -- set to false, otherwise the dlv server creation will fail.
                    -- avaliable ui interactive function to prompt for build flags: get_build_flags
                    detached = vim.fn.has("win32") == 0,
                    -- the current working directory to run dlv from, if other than
                    -- the current working directory.
                    cwd = nil,
                }
            })
            vim.keymap.set("n", "<leader>dt", dapGo.debug_test)  --debug closest test to cursor
        end
    }
}
