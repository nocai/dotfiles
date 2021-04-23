local u = require("utils")
local api = vim.api

local M = {}

M.lua_format = function()
    local bufnr = api.nvim_get_current_buf()
    local formatter_args = {"--single-quote-to-double-quote", "-i"}
    u.buf_to_stdin("lua-format", formatter_args, function(err, output)
        if err or not output then return end
        api.nvim_buf_set_lines(bufnr, 0, api.nvim_buf_line_count(bufnr), false,
                               u.split_at_newline(output))
        vim.cmd("noautocmd :update")
    end)
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

return M
