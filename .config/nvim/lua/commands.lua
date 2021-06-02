local u = require("utils")

local api = vim.api

local for_each_buffer = function(cb)
    u.for_each(vim.fn.getbufinfo({ buflisted = true }), function(b)
        if b.changed == 0 then
            cb(b)
        end
    end)
end

local commands = {}

commands.bonly = function()
    local current = api.nvim_get_current_buf()
    for_each_buffer(function(b)
        if b.bufnr ~= current then
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

commands.bdelete = function()
    local win = api.nvim_get_current_win()
    local bufnr = api.nvim_win_get_buf(win)

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

local complete_timer
local banned_filetypes = { "TelescopePrompt", "gitcommit" }
commands.complete = function()
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

        local seq = vim.bo.omnifunc ~= "" and filetype ~= "markdown" and "<C-x><C-o>" or "<C-x><C-n>"
        api.nvim_input(seq)
    end)
end

commands.save_on_cr = function()
    return vim.bo.buftype == "quickfix" and api.nvim_input("<CR>") or vim.cmd("silent w")
end

commands.yank_highlight = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
end

commands.remove = function()
    vim.fn.delete("%")
    vim.cmd("bdelete!")
end

u.lua_command("Bonly", "global.commands.bonly()")
u.lua_command("Bwipeall", "global.commands.bwipeall()")
u.lua_command("Wwipeall", "global.commands.wwipeall()")
u.lua_command("Bdelete", "global.commands.bdelete()")
u.lua_command("Remove", "global.commands.remove()")

u.map("n", "<CR>", "<cmd> lua global.commands.save_on_cr()<CR>")
u.map("n", "<Leader>cc", ":Bdelete<CR>")

u.augroup("Autocomplete", "InsertCharPre", "lua global.commands.complete()")
u.augroup("YankHighlight", "TextYankPost", "lua global.commands.yank_highlight()")

_G.global.commands = commands
