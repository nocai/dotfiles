vim.api.nvim_set_var("test#strategy", "vtr")
vim.api.nvim_set_var("test#preserve_screen", false)

vim.api.nvim_set_keymap("n", "<Leader>te", ":TestNearest<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>tf", ":TestFile<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>ts", ":TestSuite<CR>", {silent = true})
