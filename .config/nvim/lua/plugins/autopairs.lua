local npairs = require("nvim-autopairs")
npairs.setup()

OnEnter =
    function() return require("nvim-autopairs").check_break_line_char() end
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.OnEnter()", {expr = true})
