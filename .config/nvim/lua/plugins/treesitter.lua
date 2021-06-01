require("nvim-treesitter.configs").setup({
    context_commentstring = { enable = true },
    autopairs = { enable = true },
    ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "lua",
        "json",
        "jsonc",
        "yaml",
        "query",
    },
    highlight = { enable = true },
    autotag = { enable = true },
})

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
