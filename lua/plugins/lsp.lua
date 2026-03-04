return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            require("mason").setup()

            local blink = require("blink.cmp")

            -- merge existing capabilities with blink and set for ls
            local existing = vim.lsp.config["*"] and vim.lsp.config["*"].capabilities or nil
            local with_blink = blink.get_lsp_capabilities(existing)
            vim.lsp.config("*", {
                capabilities = with_blink,
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })

            -- overrides
            -- vim.lsp.config("pyright", {})
            -- vim.lsp.config("csharp_ls", {})
            -- vim.lsp.config("texlab", {})
            -- vim.lsp.config("jdtls", {})

            vim.lsp.enable({ "lua_ls", "pyright", "csharp_ls", "texlab", "jdtls" })
        end,
    },
}
