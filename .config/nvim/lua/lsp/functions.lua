local u = require("utils")
local api = vim.api

local M = {}

M.lua_format = function()
    local bufnr = api.nvim_get_current_buf()
    local formatter_args = {"--single-quote-to-double-quote", "-i"}

    u.buf_to_stdin("lua-format", formatter_args, function(err, output)
        if err or not output or not api.nvim_buf_is_loaded(bufnr) then
            return
        end

        api.nvim_buf_set_lines(bufnr, 0, -1, false, u.split_at_newline(output))
        vim.cmd("noautocmd :update")
    end)
end

return M
