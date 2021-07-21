require("nvim-treesitter.configs").setup({
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
    highlight = { enable = true },
    -- plugins
    context_commentstring = {
        enable = true,
    },
    autopairs = { enable = true },
    autotag = {
        enable = true,
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
        },
    },
    matchup = {
        enable = true,
    },
})
