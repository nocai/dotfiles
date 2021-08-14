local minsnip = require("minsnip")

local u = require("utils")

minsnip.setup(require("snippets"))

_G.global.tab_complete = function()
    if not minsnip.jump() then
        if vim.fn.pumvisible() == 1 then
            u.input("<C-y>")
        elseif _G.global.lsp.completion then
            require("lsp_compl").trigger_completion()
        else
            u.input("<C-n>")
        end
    end
end

u.map("i", "<Tab>", "<cmd> lua global.tab_complete()<CR>")
u.map("i", "<C-j>", "<cmd> lua require'minsnip'.jump()<CR>")
u.map("i", "<C-k>", "<cmd> lua require'minsnip'.jump_backwards()<CR>")
