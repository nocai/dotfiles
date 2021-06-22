require("nvim-treesitter.configs").setup({
    autopairs = { enable = true },
    indent = {
        enable = true,
    },
    ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "lua",
        "json",
        "jsonc",
        "yaml",
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ["."] = "textsubjects-smart",
        },
    },
    highlight = { enable = true },
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
