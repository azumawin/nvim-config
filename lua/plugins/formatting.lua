-- basically checks the buffer filetype and uses formatters_by_ft table to decide which formatter to use when the require("conform").format() function is called.
-- note: the function formats in-buffer, not on-disk.
return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                cs = { "csharpier" },
                tex = { "latexindent" },
                java = { "google-java-format" },
            },

            formatters = {
                stylua = {
                    prepend_args = {
                        "--column-width",
                        "100",
                        "--indent-type",
                        "Spaces",
                        "--indent-width",
                        "4",
                        "--quote-style",
                        "AutoPreferDouble",
                        "--call-parentheses",
                        "Always",
                    },
                },
            },
        },
        -- auto format buffer on save, will switch based on filetype detected
        config = function(_, opts)
            require("conform").setup(opts)

            local grp = vim.api.nvim_create_augroup("Formatting", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = grp,
                pattern = "*",
                callback = function(args)
                    require("conform").format({ bufnr = args.buf })
                end,
            })
        end,
    },
}
