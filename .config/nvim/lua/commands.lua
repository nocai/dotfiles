local u = require("utils")

local api = vim.api

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

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
            vim.cmd("bdelete " .. b.bufnr)
        end
    end)
end

commands.bwipeall = function()
    for_each_buffer(function(b)
        vim.cmd("bdelete " .. b.bufnr)
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

    vim.cmd("bdelete " .. bufnr)
end

commands.complete = (function()
    local complete_timer
    local banned_filetypes = { "TelescopePrompt" }
    local trigger_chars = "[.]"

    return function()
        local filetype = vim.bo.filetype
        if not filetype or vim.tbl_contains(banned_filetypes, filetype) then
            return
        end

        if complete_timer then
            complete_timer.restart()
            return
        end

        complete_timer = u.timer(100, nil, true, function()
            complete_timer = nil

            if vim.fn.pumvisible() == 1 or vim.fn.mode() ~= "i" then
                return
            end

            local col = api.nvim_win_get_cursor(0)[2]
            local prev_char = string.sub(api.nvim_get_current_line(), col, col)
            if not (string.match(prev_char, "%w") or string.match(prev_char, trigger_chars)) then
                return
            end

            local seq = vim.bo.omnifunc ~= "" and "<C-x><C-o>" or "<C-n>"
            api.nvim_feedkeys(t(seq), "i", true)
        end)
    end
end)()

commands.save_on_cr = function()
    return vim.bo.buftype == "quickfix" and t("<CR>") or t(":w<CR>")
end

commands.stop_recording = function()
    return vim.fn.reg_recording() ~= "" and t("q") or ""
end

commands.yank_highlight = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
end

u.command("Remove", "call delete(expand('%')) | lua global.commands.bdelete()")
u.command("VsplitLast", "vsplit #")
u.command("Lazygit", "term lazygit")
u.command("R", "w | :e")

u.lua_command("Bonly", "global.commands.bonly()")
u.lua_command("Bwipeall", "global.commands.bwipeall()")
u.lua_command("Wwipeall", "global.commands.wwipeall()")
u.lua_command("Bdelete", "global.commands.bdelete()")
u.lua_command("VsplitLast", "global.commands.vsplit_last()")

u.map("n", "<Leader>cc", ":Bdelete<CR>")
u.map("n", "<Leader>vv", ":VsplitLast<CR>")

u.map("n", "<CR>", "v:lua.global.commands.save_on_cr()", { expr = true })

u.map("n", "q", "v:lua.global.commands.stop_recording()", { expr = true })
u.map("n", "<Leader>q", "q", { silent = false })

u.augroup("Autocomplete", "InsertCharPre", "lua global.commands.complete()")
u.augroup("YankHighlight", "TextYankPost", "lua global.commands.yank_highlight()")

_G.global.commands = commands

return commands
