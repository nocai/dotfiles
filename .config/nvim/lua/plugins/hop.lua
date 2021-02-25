vim.api.nvim_set_keymap("n", "<Leader>s", ":HopChar1<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>S", ":HopChar2<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>j", ":HopWord<CR>", {silent = true})

require("hop").setup {}
