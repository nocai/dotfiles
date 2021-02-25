require"nvim-treesitter.configs".setup {
    ensure_installed = "all",
    highlight = {enable = true},
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@block.outer",
                ["ic"] = "@block.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner"
            }
        },
        move = {
            enable = true,
            goto_next_start = {
                ["]]"] = "@block.outer",
                ["}}"] = "@function.outer"
            },
            goto_previous_start = {
                ["[["] = "@block.outer",
                ["{{"] = "@function.outer"
            }
        }
    }
}

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

vim.cmd("command! TR write | edit | TSBufEnable highlight")
