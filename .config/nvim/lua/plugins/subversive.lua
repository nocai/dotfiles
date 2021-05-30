local u = require("utils")

local opts = { noremap = false }

u.map("n", "<Leader>s", "<Plug>(SubversiveSubstitute)", opts)
u.map("x", "<Leader>s", "<Plug>(SubversiveSubstitute)", opts)
u.map("n", "<Leader>ss", "<Plug>(SubversiveSubstituteLine)", opts)
u.map("n", "<Leader>S", "<Plug>(SubversiveSubstituteToEndOfLine)", opts)

u.map("n", "<Leader><Leader>s", "<Plug>(SubversiveSubstituteRange)", opts)
u.map("x", "<Leader><Leader>s", "<Plug>(SubversiveSubstituteRange)", opts)
u.map("n", "<Leader><Leader>ss", "<Plug>(SubversiveSubstituteWordRange)", opts)
