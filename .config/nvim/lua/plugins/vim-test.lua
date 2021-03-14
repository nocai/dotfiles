vim.g["test#strategy"] = {nearest = "neovim", file = "basic", suite = "basic"}
vim.g["test#javascript#jest#executable"] = "npm run test:watch"

vim.api.nvim_set_keymap("n", "<Leader>te", ":TestNearest<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>tf", ":TestFile<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>ts", ":TestSuite<CR>", {silent = true})
