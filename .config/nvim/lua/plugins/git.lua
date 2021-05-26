local u = require("utils")

u.map("n", "<Leader>g", ":Git")
u.augroup("FugitiveCustom", "BufEnter", "nmap gP :Git push<CR>", "fugitive")
