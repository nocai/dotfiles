require"nvim-treesitter.configs".setup {
    ensure_installed = {
        "javascript", "typescript", "tsx", "lua", "json", "jsonc", "yaml"
    },
    highlight = {enable = true}
}

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
