local u = require("utils")
local lsp = vim.lsp

local M = {}

M.format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end

M.set_highlights = function()
    u.exec([[
    function! LspHighlights() abort
        hi def link LspDiagnosticsDefaultError ErrorMsg
        hi def link LspDiagnosticsDefaultWarning WarningMsg
        hi def link LspDiagnosticsDefaultInformation Title
        hi def link LspDiagnosticsDefaultHint EndOfBuffer
        hi def link LspDiagnosticsUnderlineError ErrorMsg
        hi def link LspDiagnosticsUnderlineWarning WarningMsg
        hi def link LspDiagnosticsUnderlineInformation Title
        hi def link LspDiagnosticsUnderlineHint EndOfBuffer
    endfunction
    augroup LspHighlights
        autocmd!
        autocmd ColorScheme * call LspHighlights()
    augroup END
    ]])
end

M.ts_telescope_code_actions = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {diagnostics = vim.lsp.diagnostic.get_line_diagnostics()}
    local results_lsp, err = vim.lsp.buf_request_sync(0,
                                                      "textDocument/codeAction",
                                                      params, 10000)

    if err then
        print("ERROR: " .. err)
        return
    end

    if not results_lsp or vim.tbl_isempty(results_lsp) then
        print("No results from textDocument/codeAction")
        return
    end

    local _, response = next(results_lsp)
    if not response then
        print("No code actions available")
        return
    end

    local results = response.result
    if not results or #results == 0 then
        print("No code actions available")
        return
    end

    require("nvim-lsp-ts-utils").custom_action_handler(results, function()
        local actions = require("telescope.actions")
        local pickers = require("telescope.pickers")
        local conf = require("telescope.config").values
        local action_state = require("telescope.actions.state")
        local finders = require("telescope.finders")

        for i, x in ipairs(results) do x.idx = i end

        pickers.new({}, {
            prompt_title = "LSP Code Actions",
            finder = finders.new_table {
                results = results,
                entry_maker = function(line)
                    return {
                        valid = line ~= nil,
                        value = line,
                        ordinal = line.idx .. line.title,
                        display = line.idx .. ": " .. line.title
                    }
                end
            },
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(
                    function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        local val = selection.value

                        if val.edit or type(val.command) == "table" then
                            if val.edit then
                                vim.lsp.util.apply_workspace_edit(val.edit)
                            end
                            if type(val.command) == "table" then
                                vim.lsp.buf.execute_command(val.command)
                            end
                        else
                            vim.lsp.buf.execute_command(val)
                        end
                    end)

                return true
            end,
            sorter = conf.generic_sorter()
        }):find()
    end)
end

return M
