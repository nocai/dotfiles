local u = require("utils")

require("gitsigns").setup()

u.nmap("<Leader>g", ":Git<CR>")
u.nmap("<Leader>G", ":Git ", { silent = false })
