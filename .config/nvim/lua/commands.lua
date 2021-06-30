local u = require("utils")

local commands = {}

commands.vsplit = function(args)
    if not args then
        vim.cmd("vsplit")
        return
    end

    local edit_in_win = function(winnr)
        vim.cmd(winnr .. "windo edit " .. args)
    end

    local current = vim.fn.winnr()
    local right_split = vim.fn.winnr("l")
    local left_split = vim.fn.winnr("h")
    if left_split < current then
        edit_in_win(left_split)
        return
    end
    if right_split > current then
        edit_in_win(right_split)
        return
    end

    vim.cmd("vsplit " .. args)
end

vim.cmd("command! -complete=file -nargs=* Vsplit lua global.commands.vsplit(<f-args>)")
u.command("VsplitLast", "Vsplit #")
u.map("n", "<Leader>vv", ":VsplitLast<CR>")

commands.save_on_cr = function()
    return vim.bo.buftype ~= "" and u.t("<CR>") or u.t(":w<CR>")
end

u.map("n", "<CR>", "v:lua.global.commands.save_on_cr()", { expr = true })

commands.yank_highlight = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
end

u.augroup("YankHighlight", "TextYankPost", "lua global.commands.yank_highlight()")

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

vim.cmd("command! -complete=command -nargs=* TestFile lua global.commands.edit_test_file(<f-args>)")
u.map("n", "<Leader>tv", ":TestFile Vsplit<CR>")

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

u.command("WipeReg", "for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor")
u.augroup("WipeRegisters", "VimEnter", "WipeReg")

u.augroup("OnTermOpen", "TermOpen", "lua global.commands.terminal.on_open()")
u.augroup("OnTermClose", "TermClose", "lua global.commands.terminal.on_close()")

u.command("R", "w | :e")

u.command("Remove", "call delete(expand('%')) | bdelete")

_G.global.commands = commands

return commands
