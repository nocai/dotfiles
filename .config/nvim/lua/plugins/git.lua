local u = require("utils")

u.map("n", "<Leader>g", ":Git<CR>")
u.map("n", "<Leader>G", ":Git ", { silent = false })
