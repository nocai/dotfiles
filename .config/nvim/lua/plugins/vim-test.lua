vim.g["test#strategy"] = "vtr"
vim.g["test#javascript#jest#executable"] = "npm run test:watch"

vim.api.nvim_set_keymap("n", "<Leader>tn", ":TestNearest<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>tf", ":TestFile<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>ts", ":TestSuite<CR>", {silent = true})
