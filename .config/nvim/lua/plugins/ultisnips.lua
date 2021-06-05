local u = require("utils")

vim.g.UltiSnipsExpandTrigger = "<C-j>"
vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"

local input = vim.api.nvim_input
local fn = vim.fn

_G.global.tab_complete = function()
    if fn["UltiSnips#CanExpandSnippet"]() == 1 or fn["UltiSnips#CanJumpForwards"]() == 1 then
        return fn["UltiSnips#ExpandSnippetOrJump"]()
    elseif fn.pumvisible() == 1 then
        input("<C-y>")
    elseif vim.opt_local.omnifunc ~= "" and vim.bo.filetype ~= "markdown" then
        input("<C-x><C-o>")
    else
        input("<C-n>")
    end
end

u.map("i", "<Tab>", "<cmd> lua global.tab_complete()<CR>")
u.map("n", "<Leader>V", ":UltiSnipsEdit<CR>")
