local u = require("utils")

local opts = {noremap = true}

u.map("n", "m", "d", opts)
u.map("x", "m", "d", opts)
u.map("n", "mm", "dd", opts)
u.map("n", "M", "D", opts)
u.map("n", "gm", "m", opts)
