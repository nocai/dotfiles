vim.cmd([[command! -bang -nargs=* Rg 
                call fzf#vim#grep("rg --column --line-number 
                --no-heading --color=always 
                ----smart-case ".shellescape(<q-args>), 1, 
                --{'options': '--delimiter : --nth 4..'}, <bang>0)]])

vim.api.nvim_set_keymap("n", "<Leader>ff", ":Files<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fb", ":Buffers<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fl", ":BLines<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fg", ":Rg<CR>", {silent = true})
