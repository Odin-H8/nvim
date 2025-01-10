
return {
    'stevearc/overseer.nvim',
    opts = {},
    config = function ()
        require('overseer').setup({
            templates = { "builtin", "user.tunneler_build", "user.tunneler_run" }
        })

        vim.keymap.set("n", "<leader>o", "<Cmd> OverseerToggle <CR>")
    end
}
