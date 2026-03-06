local M = {}
--- returns identifier under cursor (string) or nil

function M.get_current_identifier()
    local ok, node = pcall(vim.treesitter.get_node)
    if not ok or not node then
        return nil
    end

    if node:type() == "identifier" then
        return vim.treesitter.get_node_text(node, 0)
    end
end

function M.get_help_for_current_identifier()
    local identifier = M.get_current_identifier()

    if not identifier then
        vim.notify("Identifier under cursor is nil.", vim.log.levels.WARN)
        return nil
    end

    local ok, err = pcall(vim.cmd, { cmd = "help", args = { identifier } })
    if not ok then
        vim.notify(("No help for %q"):format(identifier), vim.log.levels.WARN)
    end
end

function M.diff_original()
    print("diff?", vim.inspect(vim.wo.diff))
    if vim.wo.diff then
        vim.cmd("diffoff | only")
    else
        vim.cmd("DiffOrig")
    end
end

return M
