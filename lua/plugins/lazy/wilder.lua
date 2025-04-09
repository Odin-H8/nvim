return {
    "gelguy/wilder.nvim",
    config = function ()
        local wilder = require('wilder')
        wilder.setup({modes = {':', '/'}})

        wilder.set_option('pipeline', {
            wilder.branch(
                wilder.cmdline_pipeline({
                    -- sets the language to use, 'vim' and 'python' are supported
                    language = 'vim',
                    -- 0 turns off fuzzy matching
                    -- 1 turns on fuzzy matching
                    -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
                    fuzzy = 2,
                }),
                wilder.vim_search_pipeline({
                    -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
                    pattern = wilder.python_fuzzy_pattern(),
                    -- omit to get results in the order they appear in the buffer
                    sorter = wilder.python_difflib_sorter(),
                    -- can be set to 're2' for performance, requires pyre2 to be installed
                    -- see :h wilder#python_search() for more details
                    engine = 're',
                })
            ),
        })

        wilder.set_option('renderer', wilder.popupmenu_renderer(

            wilder.popupmenu_border_theme({
                left = {' ', wilder.popupmenu_devicons()},
                right = {' ', wilder.popupmenu_scrollbar()},
                pumblend = 30,

                -- 'single', 'double', 'rounded' or 'solid'
                -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
                border = 'rounded',

                highlights = {
                    border = 'Normal', -- highlight to use for the border
                },

                highlighter = wilder.highlighter_with_gradient({
                    wilder.basic_highlighter(),
                    wilder.lua_fzy_highlighter(), -- or wilder.lua_fzy_highlighter(),
                }),

            })
        ))
    end
}

