

return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
        local api = require("nvim-tree.api")

        require("nvim-tree").setup({
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
        })
        vim.keymap.set("n", "<leader>n", api.tree.toggle)
    end,
}
