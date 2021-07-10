require("nvim-treesitter.configs").setup({
    autopairs = { enable = true },
    autotag = {
        enable = true,
    },
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
            [";"] = "textsubjects-container-outer",
        },
    },
    highlight = { enable = true },
})
