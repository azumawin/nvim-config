return {
    "danymat/neogen",
    config = function()
        require("neogen").setup({
            languages = {
                python = {
                    template = {
                        annotation_convention = "google_docstrings",
                    },
                },
            },
        })

        vim.api.nvim_set_keymap(
            "n",
            "<Leader>ds",
            ":lua require('neogen').generate()<CR>",
            { noremap = true, silent = true }
        )
    end,
}
