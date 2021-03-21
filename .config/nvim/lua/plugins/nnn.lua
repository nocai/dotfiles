vim.g["nnn#set_default_mappings"] = false
vim.g["nnn#layout"] = {
    window = {width = 0.9, height = 0.6, highlight = "Debug"}
}
vim.g["nnn#action"] = {
    ["<C-t>"] = "tab split",
    ["<C-x>"] = "split",
    ["<C-v>"] = "vsplit"
}

vim.api.nvim_set_keymap("n", "-", ":NnnPicker %:p:h<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>n", ":NnnPicker", {silent = true})
