require("buftabline").setup {
    kill_maps = true,
    custom_command = "vertical sb",
    custom_map_prefix = "v",
    auto_hide = true
}

vim.api.nvim_set_keymap("n", "<C-n>", ":BufPrev<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-p>", ":BufNext<CR>",
                        {noremap = true, silent = true})
require("buftabline").setup {
    kill_maps = true,
    custom_command = "vertical sb",
    custom_map_prefix = "v",
    auto_hide = true
}

vim.api.nvim_set_keymap("n", "<C-n>", ":BufPrev<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-p>", ":BufNext<CR>",
                        {noremap = true, silent = true})
