vim.api.nvim_set_keymap("n", "to", ":VtrOpenRunner<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "tl", ":VtrFlushCommand<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "tt", ":VtrSendCommandToRunner<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("n", "tk", ":VtrKillRunner<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "ta", ":VtrSendFile<CR>", {silent = true})
