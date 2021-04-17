require("minsnip").setup {
    extend = {typescriptreact = "typescript"},
    edit_command = "vsplit"
}

vim.api.nvim_exec([[
augroup MinsnipCustom
    autocmd!
    autocmd BufWrite *.min lua require'minsnip'.clear_cache()
augroup END
]], false)

vim.cmd("command! MinsnipEdit lua require'minsnip'.edit()")

vim.api.nvim_set_keymap("n", "<Leader>V", ":MinsnipEdit<CR>", {silent = true})
vim.api.nvim_set_keymap("i", "<C-j>", "<cmd> lua require'minsnip'.jump(1)<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("i", "<C-k>", "<cmd> lua require'minsnip'.jump(-1)<CR>",
                        {silent = true})
