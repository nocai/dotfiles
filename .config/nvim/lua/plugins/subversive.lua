local u = require("utils")

local opts = { noremap = false }

-- q for substitute
u.map("n", "q", "<Plug>(SubversiveSubstitute)", opts)
u.map("x", "q", "<Plug>(SubversiveSubstitute)", opts)
u.map("n", "qq", "<Plug>(SubversiveSubstituteLine)", opts)
u.map("n", "Q", "<Plug>(SubversiveSubstituteToEndOfLine)", opts)

-- substitute word in 1st motion over 2nd motion
u.map("n", "<Leader>q", "<Plug>(SubversiveSubstituteRange)", opts)
u.map("x", "<Leader>q", "<Plug>(SubversiveSubstituteRange)", opts)
-- substitute current word over motion
u.map("n", "<Leader>qq", "<Plug>(SubversiveSubstituteWordRange)", opts)

-- <F1> for when I want to use macros (rarely)
u.map("n", "<F1>", "q")
