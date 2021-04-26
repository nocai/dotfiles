require("Navigator").setup({auto_save = "current", disable_on_zoom = true})

vim.api.nvim_set_keymap("n", "<A-h>",
                        "<cmd> lua require('Navigator').left()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<A-k>", "<CMD>lua require('Navigator').up()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<A-l>",
                        "<cmd> lua require('Navigator').right()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<A-j>",
                        "<cmd> lua require('Navigator').down()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<A-p>",
                        "<cmd> lua require('Navigator').previous()<CR>",
                        {noremap = true, silent = true})
