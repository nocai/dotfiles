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

M.format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end

return M
