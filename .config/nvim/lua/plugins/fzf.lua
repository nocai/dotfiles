vim.g.fzf_preview_window = {"up:60%", "ctrl-/"}

vim.api.nvim_set_keymap("n", "<Leader>ff", ":Files<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fb", ":Buffers<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fl", ":BLines<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fg", ":Rg<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fh", ":History<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fc", ":BCommits<CR>", {silent = true})
