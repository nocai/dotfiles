local u = require("utils")

local buftabline = require("buftabline")
buftabline.setup({
    tab_format = " #{i} #{n}: #{b}#{f} ",
    icon_colors = "normal",
})

buftabline.map({ prefix = "<Leader>c", cmd = "bdelete" })
buftabline.map({ prefix = "<Leader>v", cmd = "vertical sb" })

u.map("n", "<C-n>", ":Bprev<CR>")
u.map("n", "<C-p>", ":Bnext<CR>")
