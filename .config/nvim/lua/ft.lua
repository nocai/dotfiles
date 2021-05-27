local u = require("utils")

local format = string.format
local api = vim.api
local exists = vim.fn.exists

local exec = function(cmd) api.nvim_exec(cmd, false) end

local start_case = function(str)
    return string.upper(string.sub(str, 1, 1)) .. string.sub(str, 2)
end

local ft_autocmd = function(ft, fn, event)
    local augroup = start_case(ft) .. "Filetype"
    if not exists("#" .. augroup) then
        exec(format([[
        augroup %s
            autocmd!
        augroup END
        ]], augroup))
    end

    exec(format([[
    augroup %s
        autocmd %s lua filetypes.%s.%s()
    augroup END
    ]], augroup, event or ("FileType " .. ft), ft, fn))
end

_G.filetypes = {}

_G.filetypes.term = {
    setup = function()
        vim.cmd("startinsert")
        vim.cmd("setlocal nonumber norelativenumber")
    end,
    breakdown = function()
        if not string.match(vim.fn.expand("<afile>"), "nnn") then
            vim.api.nvim_input("<CR>")
        end
    end
}
ft_autocmd("term", "setup", "TermOpen *")
ft_autocmd("term", "breakdown", "TermClose *")

_G.filetypes.lua = {
    setup = function()
        u.map("n", "<Leader>T", "<Plug>PlenaryTestFile", {noremap = false},
              api.nvim_get_current_buf())
    end
}
ft_autocmd("lua", "setup")

_G.filetypes.markdown = {
    setup = function()
        vim.bo.textwidth = 80
        vim.cmd("setlocal spell")
    end
}
ft_autocmd("markdown", "setup")

_G.filetypes.typescriptreact = {
    setup = function() vim.cmd("UltiSnipsAddFiletypes typescript") end
}
ft_autocmd("typescriptreact", "setup")
