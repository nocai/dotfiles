require("bufdel").setup {next = "alternate"}

vim.api.nvim_set_keymap("n", "<Leader>x", ":BufDel<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>X", ":q<CR>", {silent = true})
