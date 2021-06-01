local u = require("utils")

local format = string.format
local api = vim.api
local exists = vim.fn.exists

local exec = function(cmd)
    api.nvim_exec(cmd, false)
end

local ft_autocmd = function(ft, fn, event)
    local augroup = u.start_case(ft) .. "Filetype"
    if not exists("#" .. augroup) then
        exec(format([[
        augroup %s
            autocmd!
        augroup END
        ]], augroup))
    end

    exec(format(
        [[
    augroup %s
        autocmd %s lua global.filetypes.%s.%s()
    augroup END
    ]],
        augroup,
        event or ("FileType " .. ft),
        ft,
        fn
    ))
end

_G.global.filetypes = {}

_G.global.filetypes.term = {
    setup = function()
        vim.cmd("startinsert")
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
    breakdown = function()
        if not string.match(vim.fn.expand("<afile>"), "nnn") then
            vim.api.nvim_input("<CR>")
        end
    end,
}

_G.global.filetypes.markdown = {
    setup = function()
        vim.opt_local.textwidth = 80
        vim.opt_local.spell = true
    end,
}

_G.global.filetypes.typescriptreact = {
    setup = function()
        vim.cmd("UltiSnipsAddFiletypes typescript")
    end,
}

_G.global.filetypes.teal = {
    format = function()
        local v = vim.fn.winsaveview()
        vim.cmd("normal gqae")
        vim.fn.winrestview(v)
    end,
    setup = function()
        u.buf_augroup("TealFormat", "BufWritePost", "lua global.filetypes.teal.format()")
    end,
}

for ft in pairs(_G.global.filetypes) do
    if _G.global.filetypes[ft].setup then
        ft_autocmd(ft, "setup", ft == "term" and "TermOpen *")
    end

    if _G.global.filetypes[ft].breakdown then
        ft_autocmd(ft, "breakdown", ft == "term" and "TermClose *")
    end
end
