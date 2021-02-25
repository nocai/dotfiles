require"nvim-treesitter.configs".setup {
    ensure_installed = "all",
    highlight = {enable = true}
}

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
