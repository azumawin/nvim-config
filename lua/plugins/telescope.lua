return {
    {
        "nvim-telescope/telescope.nvim",
        version = "v0.1.9",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({
                extensions = {
                    fzf = {},
                },
            })

            telescope.load_extension("fzf")

            vim.keymap.set("n", "<leader>fc", function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end, { desc = "Telescope: find config" })

            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: find file" })

            vim.keymap.set("n", "<leader>fg", function()
                builtin.live_grep({ cwd = vim.fn.expand("%:p:h") })
            end, { desc = "Telescope: find grep" })
        end,
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").load_extension("file_browser")

            vim.keymap.set("n", "<leader>fb", function()
                require("telescope").extensions.file_browser.file_browser({
                    use_fd = true,
                    path = vim.fn.expand("%:p:h"),
                    select_buffer = true,
                    hidden = { file_browser = false, folder_browser = false },
                    respect_gitignore = true,
                    no_ignore = false,
                })
            end, { desc = "Telescope: file browser" })

            vim.keymap.set("n", "<leader>fh", function()
                require("telescope").extensions.file_browser.file_browser({
                    use_fd = true,
                    path = vim.fn.expand("%:p:h"),
                    select_buffer = true,
                    hidden = { file_browser = true, folder_browser = true },
                    respect_gitignore = false,
                    no_ignore = true,
                })
            end, { desc = "Telescope: file hidden" })
        end,
    },
}
