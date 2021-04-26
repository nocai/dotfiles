vim.api.nvim_set_keymap("n", "<A-n>",
                        "<cmd>lua require'illuminate'.next_reference{wrap=true}<CR>",
                        {noremap = true})
vim.api.nvim_set_keymap("n", "<A-N>",
                        "<cmd>lua require'illuminate'.next_reference{reverse=true,wrap=true}<CR>",
                        {noremap = true})
