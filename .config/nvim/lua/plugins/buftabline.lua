local u = require("utils")

local buftabline = require("buftabline")
buftabline.setup({
    tab_format = " #{i} #{n}: #{b}#{f} ",
    icon_colors = "normal",
})

buftabline.map({ prefix = "<Leader>c", cmd = "bdelete" })
buftabline.map({ prefix = "<Leader>v", cmd = "vertical sb" })

u.nmap("<C-n>", ":BufPrev<CR>")
u.nmap("<C-p>", ":BufNext<CR>")
