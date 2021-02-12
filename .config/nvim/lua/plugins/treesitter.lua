require"nvim-treesitter.configs".setup {
    ensure_installed = "maintained",
    highlight = {enable = true}
}

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

vim.cmd("command! TR write | edit | TSBufEnable highlight")
