local npairs = require("nvim-autopairs")

npairs.setup {
    check_ts = true,
    ignored_next_char = "[%w%.]",
    check_line_pair = false
}

require("nvim-treesitter.configs").setup {autopairs = {enable = true}}

_G.on_enter = function() return npairs.check_break_line_char() end
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.on_enter()", {expr = true})
