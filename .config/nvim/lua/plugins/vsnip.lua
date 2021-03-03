vim.g.vsnip_filetypes = {
    javascriptreact = {"javascript"},
    typescriptreact = {"typescript"}
}

vim.api
    .nvim_set_keymap("n", "<Leader>v", ":VsnipOpenSplit<CR>", {silent = true})
