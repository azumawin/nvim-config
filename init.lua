-- Set up options and keymaps before loading lazynvim
require("opts")
require("keymaps")

-- Put lazy.nvim on runtimepath
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
    { import = "plugins.treesitter" },

    { import = "plugins.colorscheme" },

    { import = "plugins.telescope" },

    { import = "plugins.lsp" },

    { import = "plugins.formatting" },

    { import = "plugins.linting" },

    { import = "plugins.autocomplete" },

    { import = "plugins.docstrings" },

    { "tpope/vim-surround" },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
})

-- Override background color
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "CurSearch", { bg = "#ff0000" }) -- set bg color of the word under cursor in hlsearch to red

-- transparent background
-- vim.cmd([[
--   highlight Normal       ctermbg=NONE guibg=NONE
--   highlight NormalNC     ctermbg=NONE guibg=NONE
--   highlight EndOfBuffer  ctermbg=NONE guibg=NONE
--   highlight SignColumn   ctermbg=NONE guibg=NONE
--   highlight VertSplit    ctermbg=NONE guibg=NONE
-- ]])
