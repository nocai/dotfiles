local buftabline = require("buftabline")

local u = require("utils")

buftabline.setup({
    tab_format = " #{n}: #{b}#{f} #{i} ",
    icon_colors = "normal",
    tabpage_buffers = true,
    auto_hide = true,
})

buftabline.map({ prefix = "<Leader>c", cmd = "bdelete" })
buftabline.map({ prefix = "<Leader>v", cmd = "vertical sb" })

u.nmap("<C-n>", ":BufPrev<CR>")
u.nmap("<C-p>", ":BufNext<CR>")
