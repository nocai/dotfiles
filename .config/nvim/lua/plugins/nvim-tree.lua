vim.api.nvim_set_keymap("n", "-", ":NvimTreeFindFile<CR>", {silent = true})
vim.api
    .nvim_set_keymap("n", "<Leader>n", ":NvimTreeToggle<CR>", {silent = true})

vim.api.nvim_set_var("nvim_tree_show_icons",
                     {git = true, folders = false, files = false})
