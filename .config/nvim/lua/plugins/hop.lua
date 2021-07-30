local u = require("utils")

require("hop").setup()

u.nmap("<Leader><Leader>", ":HopWord<CR>")
u.nmap("<Leader>.", ":HopChar1<CR>")
