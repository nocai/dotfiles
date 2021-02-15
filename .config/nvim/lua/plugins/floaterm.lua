vim.api.nvim_set_var("floaterm_width", 0.8)
vim.api.nvim_set_var("floaterm_height", 0.8)

vim.cmd("command! Vifm FloatermNew vifm")
vim.cmd("command! Git FloatermNew lazygit")

vim.api.nvim_set_keymap("n", "-", ":Vifm<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "tg", ":Git<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>tn", ":FloatermNext<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>tp", ":FloatermPrev<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>tf", ":FloatermToggle<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("t", "<Leader>tf", "<C-\\><C-n>:FloatermToggle<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("t", "<Leader>tp", "<C-\\><C-n>:FloatermPrev<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("t", "<Leader>tf", "<C-\\><C-n>:FloatermToggle<CR>",
                        {silent = true})
