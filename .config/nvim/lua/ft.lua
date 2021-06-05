local u = require("utils")

_G.global.filetypes = {
    markdown = {
        setup = function()
            vim.cmd("setlocal textwidth=80 spell")
        end,
    },
    typescriptreact = {
        setup = function()
            vim.cmd("UltiSnipsAddFiletypes typescript")
        end,
    },

    teal = {
        format = function()
            local v = vim.fn.winsaveview()
            vim.cmd("normal gqae")
            vim.fn.winrestview(v)
        end,

        setup = function()
            u.buf_augroup("TealFormat", "BufWritePost", "lua global.filetypes.teal.format()")
        end,
    },
}

for ft in pairs(_G.global.filetypes) do
    local name = u.start_case(ft) .. "CustomFt"
    local event = "FileType"
    local fn = string.format("lua.global.filetypes.%s.setup()", ft)
    u.augroup(name, event, fn, ft)
end
