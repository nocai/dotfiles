local u = require("utils")

-- sort folders at top
vim.g.dirvish_mode = [[:sort ,^.*[\/],]]

-- replace netrw
vim.g.loaded_netrwPlugin = true
vim.cmd("command! -nargs=? -complete=dir Explore Dirvish <args>")
vim.cmd("command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>")
vim.cmd("command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>")

_G.global.dirvish_config = function()
    u.buf_map("n", "a", ":!touch %", { silent = false })
    u.buf_map("n", "A", ":!mkdir %", { silent = false })
end

u.augroup("DirvishConfig", "FileType", "lua global.dirvish_config()", "dirvish")
