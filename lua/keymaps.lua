-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- open split terminal on the right: botright vsplit | terminal
vim.keymap.set("n", "<leader>tr", function()
    -- buffer dir if file is saved, else current working dir
    local bufname = vim.api.nvim_buf_get_name(0)
    local dir
    if bufname ~= "" then
        dir = vim.fn.fnamemodify(bufname, ":p:h")
    else
        dir = vim.fn.getcwd()
    end

    vim.cmd("botright vsplit")
    vim.cmd("terminal")

    -- set terminal's working dir (run inside the shell)
    vim.fn.chansend(vim.b.terminal_job_id, "cd " .. vim.fn.shellescape(dir) .. "\n")
    vim.cmd("startinsert")
end, { desc = "Right terminal in buffer dir" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
local grp = vim.api.nvim_create_augroup("LSPstuff", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = grp,
    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
})

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- it should search the entire token, not just the identifier bcus now if i do it for vim.keymap.set
-- it just opens up the set documentation for me which is unrelated, so it should try to find from longest to shortest
-- try vim.keymap.set, then keymap.set then set then fail. mby it would be simpler to just use <cWORD>? need to check
vim.keymap.set(
    "n",
    "<leader>z",
    require("utils").get_help_for_current_identifier,
    { desc = "Call :h <identifier> for identifier under cursor, uses treesitter to parse" }
)

-- diff toggle
vim.keymap.set("n", "\\", require("utils").diff_original, { desc = "Diff with original toggle" })
