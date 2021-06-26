local u = require("utils")

local api = vim.api

local for_each_buffer = function(cb, force)
    u.for_each(vim.fn.getbufinfo({ buflisted = true }), function(b)
        if b.changed == 0 and not force then
            cb(b)
        end
    end)
end

local commands = {}

commands.bonly = function(bufnr)
    bufnr = bufnr or api.nvim_get_current_buf()
    for_each_buffer(function(b)
        if b.bufnr ~= bufnr then
            vim.cmd("silent bdelete " .. b.bufnr)
        end
    end)
end

commands.bwipeall = function()
    for_each_buffer(function(b)
        vim.cmd("silent bdelete " .. b.bufnr)
    end)
end

commands.wwipeall = function()
    local win = api.nvim_get_current_win()
    u.for_each(vim.fn.getwininfo(), function(w)
        if w.winid ~= win then
            if w.loclist == 1 then
                vim.cmd("lclose")
            elseif w.quickfix == 1 then
                vim.cmd("cclose")
            else
                vim.cmd(w.winnr .. " close")
            end
        end
    end)
end

commands.bdelete = function(bufnr)
    local win = api.nvim_get_current_win()
    bufnr = bufnr or api.nvim_win_get_buf(win)

    local target
    local previous = vim.fn.bufnr("#")
    if previous ~= -1 and previous ~= bufnr and vim.fn.buflisted(previous) == 1 then
        target = previous
    end

    if not target then
        for_each_buffer(function(b)
            if not target and b.bufnr ~= bufnr then
                target = b.bufnr
            end
        end)
    end

    if not target then
        target = api.nvim_create_buf(false, false)
    end

    local windows = vim.fn.getbufinfo(bufnr)[1].windows
    u.for_each(windows, function(w)
        api.nvim_win_set_buf(w, target)
    end)

    vim.cmd("silent bdelete " .. bufnr)
end

commands.save_on_cr = function()
    return vim.bo.buftype == "quickfix" and u.t("<CR>") or u.t(":w<CR>")
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

u.command("Remove", "call delete(expand('%')) | lua global.commands.bdelete()")
u.command("VsplitLast", "vsplit #")
u.command("Lazygit", "term lazygit")
u.command("R", "w | :e")

u.lua_command("Bonly", "global.commands.bonly()")
u.lua_command("Bwipeall", "global.commands.bwipeall()")
u.lua_command("Wwipeall", "global.commands.wwipeall()")
u.lua_command("Bdelete", "global.commands.bdelete()")
u.lua_command("TestFile", "global.commands.edit_test_file()")

u.map("n", "<Leader>cc", ":Bdelete<CR>")
u.map("n", "<Leader>vv", ":VsplitLast<CR>")

u.map("n", "<CR>", "v:lua.global.commands.save_on_cr()", { expr = true })

u.map("n", "q", "v:lua.global.commands.stop_recording()", { expr = true })
u.map("n", "<Leader>q", "q", { silent = false })

u.augroup("YankHighlight", "TextYankPost", "lua global.commands.yank_highlight()")

_G.global.commands = commands

return commands
