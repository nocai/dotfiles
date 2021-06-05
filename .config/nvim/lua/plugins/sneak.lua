local u = require("utils")

vim.g["sneak#label"] = true
vim.g["sneak#use_ic_scs"] = true

-- replace f with sneak
u.map("n", "f", "<Plug>Sneak_s", { noremap = false })
u.map("n", "F", "<Plug>Sneak_S", { noremap = false })
u.map("o", "f", "<Plug>Sneak_s", { noremap = false })
u.map("o", "F", "<Plug>Sneak_S", { noremap = false })

-- let t seek and highlight matches
u.map("n", "t", "<Plug>Sneak_t", { noremap = false })
u.map("n", "T", "<Plug>Sneak_T", { noremap = false })
u.map("o", "t", "<Plug>Sneak_t", { noremap = false })
u.map("o", "T", "<Plug>Sneak_T", { noremap = false })

-- keep original f around
u.map("n", "<Leader>f", "<Plug>Sneak_f", { noremap = false })
u.map("n", "<Leader>F", "<Plug>Sneak_F", { noremap = false })
u.map("o", "<Leader>f", "<Plug>Sneak_f", { noremap = false })
u.map("o", "<Leader>F", "<Plug>Sneak_F", { noremap = false })
