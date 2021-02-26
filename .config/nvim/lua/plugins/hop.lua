require("hop").setup {}

vim.api.nvim_set_keymap("n", "<Leader>s", ":HopChar1<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>S", ":HopChar2<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>j", ":HopWord<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>l", ":HopLine<CR>", {silent = true})
