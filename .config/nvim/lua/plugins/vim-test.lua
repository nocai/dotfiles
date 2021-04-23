vim.g["test#strategy"] = "neovim"
vim.g["test#strategy"] = {nearest = "neovim", file = "neovim", suite = "basic"}

vim.cmd("command! TestCoverage term npm run test:cov")

vim.api.nvim_set_keymap("n", "<Leader>te", ":TestNearest<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>tf", ":TestFile<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>ts", ":TestSuite<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>tc", ":TestCoverage<CR>", {silent = true})
