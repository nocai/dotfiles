local npairs = require("nvim-autopairs")

npairs.setup {ignored_next_char = "[%w%.]", check_line_pair = false}

_G.on_enter = function() return npairs.check_break_line_char() end
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.on_enter()", {expr = true})
