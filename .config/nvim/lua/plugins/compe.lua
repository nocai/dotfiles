require"compe".setup {
    preselect = false,
    source = {
        path = true,
        buffer = true,
        vsnip = {priority = 9999},
        nvim_lsp = true,
        nvim_lua = true
    }
}

vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()",
                        {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-y>", "compe#confirm(\"<C-y>\")",
                        {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close(\"<C-e>\")",
                        {expr = true, silent = true})
