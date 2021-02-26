vim.api.nvim_set_var("vista_default_executive", "nvim_lsp")

vim.api.nvim_set_keymap("n", "<Leader>v", ":Vista<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fv", ":Vista finder nvim_lsp<CR>",
                        {silent = true})
