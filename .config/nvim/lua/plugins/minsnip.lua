local minsnip = require("minsnip")

minsnip.setup {
    extend = {typescriptreact = "typescript"},
    edit_command = "vsplit"
}

vim.api.nvim_exec([[
augroup MinsnipCustom
    autocmd!
    autocmd BufWrite *.min lua require'minsnip'.clear_cache()
augroup END
]], false)

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        vim.api.nvim_input("<C-y>")
    elseif minsnip.can_expand() then
        minsnip.jump(1)
    elseif vim.bo.omnifunc ~= "" then
        vim.api.nvim_input("<C-x><C-o>")
    else
        vim.api.nvim_input("<Tab>")
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "<cmd> lua tab_complete()<CR>",
                        {silent = true})

vim.cmd("command! MinsnipEdit lua require'minsnip'.edit()")

vim.api.nvim_set_keymap("n", "<Leader>V", ":MinsnipEdit<CR>", {silent = true})
vim.api.nvim_set_keymap("i", "<C-j>", "<cmd> lua require'minsnip'.jump(1)<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("i", "<C-k>", "<cmd> lua require'minsnip'.jump(-1)<CR>",
                        {silent = true})
