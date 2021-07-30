require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "lua",
        "json",
        "jsonc",
        "yaml",
    },
    highlight = { enable = true },
    -- plugins
    context_commentstring = {
        enable = true,
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
        },
    },
})
