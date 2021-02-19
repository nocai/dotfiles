vim.api.nvim_set_var("vsnip_filetypes", {
    javascriptreact = {"javascript"},
    typescriptreact = {"typescript"}
})

vim.api.nvim_set_keymap("n", "<Leader>c", "<Plug>(vsnip-select-text)", {})
vim.api.nvim_set_keymap("s", "<Leader>c", "<Plug>(vsnip-select-text)", {})
vim.api.nvim_set_keymap("n", "<Leader>C", "<Plug>(vsnip-cut-text)", {})
vim.api.nvim_set_keymap("s", "<Leader>c", "<Plug>(vsnip-cut-text)", {})

vim.api
    .nvim_set_keymap("n", "<Leader>v", ":VsnipOpenSplit<CR>", {silent = true})

vim.api.nvim_set_keymap("i", "<S-Tab>",
                        "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-o>A'",
                        {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>",
                        "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)': '<C-o>A'",
                        {expr = true})
