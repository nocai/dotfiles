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

M.define_augroup = function(name, event, fn, ft)
    api.nvim_exec(format([[
    augroup %s
        autocmd!
        autocmd %s %s %s
    augroup END
    ]], name, event, ft or "*", fn), false)
end

M.define_buf_augroup = function(name, event, fn)
    api.nvim_exec(format([[
    augroup %s
        autocmd! * <buffer>
        autocmd %s <buffer> %s
    augroup END
    ]], name, event, fn), false)
end

M.buf_to_string = function(bufnr)
    if bufnr == nil then bufnr = 0 end
    local content = api.nvim_buf_get_lines(bufnr, 0, -1, false)
    return table.concat(content, "\n")
end

M.split_at_newline = function(str)
    local split = {}
    for line in string.gmatch(str, "([^\n]*)\n?") do
        table.insert(split, line)
    end
    table.remove(split)
    return split
end

M.buf_to_stdin = function(cmd, args, handler)
    local close_handle = function(handle)
        if handle and not handle:is_closing() then handle:close() end
    end

    local code_is_ok = function(code) return code == 0 and true or false end

    local handle, ok
    local output, error_output = "", ""

    local handle_stdout = vim.schedule_wrap(
                              function(err, chunk)
            if err then error("stdout error: " .. err) end

            if chunk then output = output .. chunk end
            if not chunk then
                vim.wait(5000, function() return ok ~= nil end, 10)
                if not ok and error_output == "" then
                    error_output = output
                    output = ""
                end

                if output == "" then output = nil end
                if error_output == "" then error_output = nil end
                handler(error_output, output)
            end
        end)

    local handle_stderr = function(err, chunk)
        if err then error("stderr error: " .. err) end
        if chunk then error_output = error_output .. chunk end
    end

    local stdin = uv.new_pipe(true)
    local stdout = uv.new_pipe(false)
    local stderr = uv.new_pipe(false)
    local stdio = {stdin, stdout, stderr}

    handle = uv.spawn(cmd, {args = args, stdio = stdio}, function(code)
        ok = code_is_ok(code)

        stdout:read_stop()
        stderr:read_stop()

        close_handle(stdin)
        close_handle(stdout)
        close_handle(stderr)
        close_handle(handle)
    end)

    uv.read_start(stdout, handle_stdout)
    uv.read_start(stderr, handle_stderr)

    stdin:write(M.buf_to_string(), function() stdin:close() end)
end

return M
