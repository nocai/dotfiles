vim.g.UltiSnipsExpandTrigger = "<C-j>"
vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"

vim.api.nvim_set_keymap("n", "<Leader>V", ":UltiSnipsEdit<CR>", {silent = true})
