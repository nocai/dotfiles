local format = string.format
local uv = vim.loop
local api = vim.api

local get_map_options = function(custom_options)
    local options = {noremap = true, silent = true}
    if custom_options then
        options = vim.tbl_extend("force", options, custom_options)
    end
    return options
end

local M = {}

M.map = function(mode, target, source, opts, bufnr)
    return bufnr and
               api.nvim_buf_set_keymap(bufnr, mode, target, source,
                                       get_map_options(opts)) or
               api.nvim_set_keymap(mode, target, source, get_map_options(opts))
end

_G.inspect = function(...) print(vim.inspect(...)) end

local start_time
M.timer = {
    start = function() start_time = uv.now() end,
    stop = function()
        print(uv.now() - start_time .. " ms")
        start_time = nil
    end,

    start_nano = function() start_time = uv.hrtime() end,
    stop_nano = function()
        print(uv.hrtime() - start_time .. " ns")
        start_time = nil
    end
}
_G.timer = M.timer

M.define_command =
    function(name, fn) vim.cmd(format("command! %s %s", name, fn)) end

M.define_lua_command =
    function(name, fn) M.define_command(name, "lua " .. fn) end

M.augroup = function(name, event, fn, ft)
    api.nvim_exec(format([[
    augroup %s
        autocmd!
        autocmd %s %s %s
    augroup END
    ]], name, event, ft or "*", fn), false)
end

M.buf_augroup = function(name, event, fn)
    api.nvim_exec(format([[
    augroup %s
        autocmd! * <buffer>
        autocmd %s <buffer> %s
    augroup END
    ]], name, event, fn), false)
end

return M
