require("nvim-autopairs").setup()

local npairs = require("nvim-autopairs")
OnEnter = function() return npairs.check_break_line_char() end
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.OnEnter()",
                        {expr = true, noremap = true})
