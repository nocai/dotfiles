require("buftabline").setup {
    kill_maps = true,
    custom_command = "vertical sb",
    custom_map_prefix = "v"
}

vim.api.nvim_set_keymap("n", "<C-n>", ":BufPrev<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<C-p>", ":BufNext<CR>", {silent = true})
