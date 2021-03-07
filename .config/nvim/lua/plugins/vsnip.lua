vim.g.vsnip_filetypes = {
    javascriptreact = {"javascript"},
    typescriptreact = {"typescript"}
}

vim.api
    .nvim_set_keymap("n", "<Leader>V", ":VsnipOpenSplit<CR>", {silent = true})
