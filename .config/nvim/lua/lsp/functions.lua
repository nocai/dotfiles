local nvim_lsp = vim.lsp

local M = {}

M.organize_imports = function()
    local params = nvim_lsp.util.make_range_params()
    params.context = {diagnostics = {}, only = {"source.organizeImports"}}

    local responses, err = nvim_lsp.buf_request_sync(0,
                                                     "textDocument/codeAction",
                                                     params, 500)

    if err then
        print("ERROR: " .. err)
        return
    end

    if not responses or vim.tbl_isempty(responses) then return end

    for _, response in pairs(responses) do
        for _, result in pairs(response.result or {}) do
            if result.edit then
                nvim_lsp.util.apply_workspace_edit(result.edit)
            else
                nvim_lsp.buf.execute_command(result.command)
            end
        end
    end
end

return M
