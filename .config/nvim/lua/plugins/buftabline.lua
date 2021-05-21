local u = require("utils")

require("buftabline").setup {
    kill_maps = true,
    custom_command = "vertical sb",
    custom_map_prefix = "v",
    auto_hide = true,
    icons = true,
    icon_colors = "normal"
}

u.map("n", "<C-n>", ":BufPrev<CR>")
u.map("n", "<C-p>", ":BufNext<CR>")
