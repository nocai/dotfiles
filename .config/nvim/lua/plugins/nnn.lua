local u = require("utils")

vim.g["nnn#set_default_mappings"] = false
vim.g["nnn#layout"] = { window = { width = 0.9, height = 0.6 } }
vim.g["nnn#session"] = "local"
vim.g["nnn#action"] = {
    ["<C-t>"] = "tab split",
    ["<C-x>"] = "split",
    ["<C-v>"] = "vsplit",
}

u.map("n", "-", ":NnnPicker %:p:h<CR>")
u.map("n", "<Leader>n", ":NnnPicker")
