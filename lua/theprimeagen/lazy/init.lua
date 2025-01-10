return {

    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    "eandrju/cellular-automaton.nvim",
    {
        "karb94/neoscroll.nvim",
        config = function ()
            local neoscroll = require('neoscroll')
            neoscroll.setup({
                mappings = {},
                hide_cursor = true,          -- Hide cursor while scrolling
                stop_eof = true,             -- Stop at <EOF> when scrolling downwards
                respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing = 'linear',           -- Default easing function
                pre_hook = nil,              -- Function to run before the scrolling animation starts
                post_hook = nil,             -- Function to run after the scrolling animation ends
                performance_mode = false,    -- Disable "Performance Mode" on all buffers.
                ignored_events = {           -- Events ignored while scrolling
                    'WinScrolled', 'CursorMoved'
                },
            })
            local keymap = {
                ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 150 }) end;
                ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 150 }) end;
                ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450 }) end;
                ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450 }) end;
                ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
                ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100 }) end;
                ["zt"]    = function() neoscroll.zt({ half_win_duration = 250 }) end;
                ["zz"]    = function() neoscroll.zz({ half_win_duration = 250 }) end;
                ["zb"]    = function() neoscroll.zb({ half_win_duration = 250 }) end;
            }
            local modes = { 'n', 'v', 'x' }
            for key, func in pairs(keymap) do
                vim.keymap.set(modes, key, func)
            end
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function ()
            require("nvim-autopairs").setup{}
        end
    },
    {
        "akinsho/bufferline.nvim",
        config = function ()
            require("bufferline").setup{}

            function Map(mode, lhs, rhs, opts)
                local options = { noremap = true, silent = true }
                if opts then
                    options = vim.tbl_extend("force", options, opts)
                end
                vim.keymap.set(mode, lhs, rhs, options)
            end

            Map('n', "<Leader>1", "<Cmd>BufferLineGoToBuffer 1 <CR>")
            Map('n', "<Leader>2", "<Cmd>BufferLineGoToBuffer 2 <CR>")
            Map('n', "<Leader>3", "<Cmd>BufferLineGoToBuffer 3 <CR>")
            Map('n', "<Leader>4", "<Cmd>BufferLineGoToBuffer 4 <CR>")
            Map('n', "<Leader>5", "<Cmd>BufferLineGoToBuffer 5 <CR>")
            Map('n', "<Leader>6", "<Cmd>BufferLineGoToBuffer 6 <CR>")
            Map('n', "<Leader>7", "<Cmd>BufferLineGoToBuffer 7 <CR>")
            Map('n', "<Leader>8", "<Cmd>BufferLineGoToBuffer 8 <CR>")
            Map('n', "<Leader>9", "<Cmd>BufferLineGoToBuffer 9 <CR>")

            Map('n', "<Leader>-", "<Cmd>BufferLineCycleNext <CR>")
            Map('n', "<Leader>.", "<Cmd>BufferLineCyclePrev <CR>")

            -- Closing tabs, (pick, all to the right, all to the left and everything except open tab)
            Map('n', "<leader>cc", "<Cmd>BufferLinePickClose <CR>")
            Map('n', "<leader>cr", "<Cmd>BufferLineCloseRight <CR>")
            Map('n', "<leader>cl", "<Cmd>BufferLineCloseLeft <CR>")
            Map('n', "<leader>ca", "<Cmd>BufferLineCloseOthers <CR>")
        end
    }
}
