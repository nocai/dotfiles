local u = require("utils")

vim.g["sneak#label"] = true
vim.g["sneak#use_ic_scs"] = true
vim.g["sneak#s_next"] = true

-- replace normal mode f with 2 character sneak
u.map("n", "f", "<Plug>Sneak_s", { noremap = false })
u.map("n", "F", "<Plug>Sneak_S", { noremap = false })

-- f behavior is better for operator pending mode
u.map("o", "f", "<Plug>Sneak_f", { noremap = false })
u.map("o", "F", "<Plug>Sneak_F", { noremap = false })

-- also allow seeking for t
u.map("n", "t", "<Plug>Sneak_t", { noremap = false })
u.map("n", "T", "<Plug>Sneak_T", { noremap = false })
u.map("o", "t", "<Plug>Sneak_t", { noremap = false })
u.map("o", "T", "<Plug>Sneak_T", { noremap = false })
