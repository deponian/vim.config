local M = {}

local buf_attached = {}

-- get_node is builtin in v0.9+, get_node_at_cursor is for older versions
local get_node_at_cursor = vim.treesitter.get_node or require('nvim-treesitter.ts_utils').get_node_at_cursor
function M.get_references(bufnr)
    local ok, locals = pcall(require, 'nvim-treesitter.locals')
    if not ok then
        return
    end

    local node_at_point = get_node_at_cursor()
    if not node_at_point then
        return
    end

    local refs = {}
    local def_node, scope, kind = locals.find_definition(node_at_point, bufnr)
    local usages = locals.find_usages(def_node, scope, bufnr)
    for _, node in ipairs(usages) do
        if kind ~= nil and node == def_node then
            local range = { def_node:range() }
            table.insert(refs, {
                { range[1], range[2] },
                { range[3], range[4] },
                vim.lsp.protocol.DocumentHighlightKind.Write,
            })
        else
            local range = { node:range() }
            table.insert(refs, {
                { range[1], range[2] },
                { range[3], range[4] },
                vim.lsp.protocol.DocumentHighlightKind.Read,
            })
        end
    end

    return refs
end

function M.is_ready(bufnr)
    return buf_attached[bufnr] and vim.api.nvim_buf_get_option(bufnr, 'filetype') ~= 'yaml'
end

function M.attach(bufnr)
    buf_attached[bufnr] = true
end

function M.detach(bufnr)
    buf_attached[bufnr] = nil
end

return M
