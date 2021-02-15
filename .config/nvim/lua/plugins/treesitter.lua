local utils = require("utils")

require"nvim-treesitter.configs".setup {
    ensure_installed = "maintained",
    highlight = {enable = true},
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        }
    },
    swap = {
        enable = true,
        swap_next = {["<leader>w"] = "@parameter.inner"},
        swap_previous = {["<leader>W"] = "@parameter.inner"}
    },
    lsp_interop = {
        enable = true,
        peek_definition_code = {
            ["df"] = "@function.outer",
            ["dF"] = "@class.outer"
        }
    }
}

utils.opt("w", "foldmethod", "expr")
utils.opt("w", "foldexpr", "nvim_treesitter#foldexpr()")

utils.cmd("command! TR write | edit | TSBufEnable highlight")
