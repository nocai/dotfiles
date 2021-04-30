require("Navigator").setup({auto_save = "current", disable_on_zoom = true})

vim.api.nvim_set_keymap("n", "<C-h>",
                        "<cmd> lua require('Navigator').left()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-l>",
                        "<cmd> lua require('Navigator').right()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-j>",
                        "<cmd> lua require('Navigator').down()<CR>",
                        {noremap = true, silent = true})
