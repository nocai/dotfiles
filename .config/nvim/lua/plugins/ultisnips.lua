vim.g.UltiSnipsExpandTrigger = "<C-j>"
vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        vim.api.nvim_input("<C-y>")
    elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or
        vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        return vim.fn["UltiSnips#ExpandSnippetOrJump"]()
    elseif vim.bo.omnifunc ~= "" then
        vim.api.nvim_input("<C-x><C-o>")
    else
        vim.api.nvim_input("<C-n>")
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "<cmd> lua tab_complete()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>V", ":UltiSnipsEdit<CR>", {silent = true})
