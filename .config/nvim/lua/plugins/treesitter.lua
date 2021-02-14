local utils = require("utils")

require"nvim-treesitter.configs".setup {
    ensure_installed = "maintained",
    highlight = {enable = true}
}

utils.opt("w", "foldmethod", "expr")
utils.opt("w", "foldexpr", "nvim_treesitter#foldexpr()")

utils.cmd("command! TR write | edit | TSBufEnable highlight")
