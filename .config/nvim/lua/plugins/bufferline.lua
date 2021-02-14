require("bufferline").setup {
    options = {
        show_buffer_close_icons = false,
        separator_style = "thin",
        always_show_bufferline = true
    },
    highlights = {buffer_selected = {gui = "bold"}}
}

vim.api.nvim_set_keymap("n", "[b", ":BufferLineCyclePrev<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "]b", ":BufferLineCycleNext<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[B", ":BufferLineMovePrev<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "]B", ":BufferLineMoveNext<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gb", ":BufferLinePick<CR>",
                        {noremap = true, silent = true})
