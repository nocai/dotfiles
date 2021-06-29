local u = require("utils")

local commands = {}

commands.save_on_cr = function()
    return vim.bo.buftype ~= "" and u.t("<CR>") or u.t(":w<CR>")
end

commands.stop_recording = function()
    return vim.fn.reg_recording() ~= "" and u.t("q") or ""
end

commands.yank_highlight = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
end

commands.edit_test_file = function(cmd, post)
    cmd = cmd or "e"
    local scandir = require("plenary.scandir")

    local root, ft = vim.fn.expand("%:t:r"), vim.bo.filetype
    -- escape potentially conflicting characters in filename
    root = root:gsub("%-", "%%-")
    root = root:gsub("%.", "%%.")

    local patterns = {}
    if ft == "lua" then
        table.insert(patterns, "_spec")
    elseif ft == "typescript" or ft == "typescriptreact" then
        table.insert(patterns, "%.test")
        table.insert(patterns, "%.spec")
    end

    local final_patterns = {}
    for _, pattern in ipairs(patterns) do
        -- go from test file to non-test file
        if root:match(pattern) then
            pattern = u.replace(root, pattern, "")
        else
            pattern = root .. pattern
        end
        -- make sure extension matches
        pattern = pattern .. "%." .. vim.fn.expand("%:e") .. "$"
        table.insert(final_patterns, pattern)
    end

    scandir.scan_dir_async(vim.fn.getcwd(), {
        depth = 5,
        search_pattern = final_patterns,
        on_exit = vim.schedule_wrap(function(files)
            assert(files[1], "test file not found")
            vim.cmd(cmd .. " " .. files[1])
            if post then
                post()
            end
        end),
    })
end

commands.terminal = {
    on_open = function()
        -- start in insert mode and turn off line numbers
        vim.cmd("startinsert")
        vim.cmd("setlocal nonumber norelativenumber")
    end,

    -- suppress exit code message
    on_close = function()
        if not string.match(vim.fn.expand("<afile>"), "nnn") then
            vim.api.nvim_input("<CR>")
        end
    end,
}

u.augroup("OnTermOpen", "TermOpen", "lua global.commands.terminal.on_open()")
u.augroup("OnTermClose", "TermClose", "lua global.commands.terminal.on_close()")

u.command("Remove", "call delete(expand('%')) | lua global.commands.bdelete()")
u.command("VsplitLast", "vsplit #")
u.lua_command("TestFile", "global.commands.edit_test_file()")

u.command("R", "w | :e")

u.map("n", "<Leader>vv", ":VsplitLast<CR>")
u.map("n", "<CR>", "v:lua.global.commands.save_on_cr()", { expr = true })
u.map("n", "q", "v:lua.global.commands.stop_recording()", { expr = true })
u.map("n", "<Leader>q", "q", { silent = false })

u.augroup("YankHighlight", "TextYankPost", "lua global.commands.yank_highlight()")

_G.global.commands = commands

return commands
