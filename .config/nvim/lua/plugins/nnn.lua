local u = require("utils")

require("nnn").setup({
    set_default_mappings = false,
    session = "local",
    command = "nnn -C",
    layout = { window = { width = 0.9, height = 0.6 } },
    action = {
        ["<C-t>"] = "tab split",
        ["<C-x>"] = "split",
        ["<C-v>"] = "Vsplit",
    },
})

u.map("n", "-", ":NnnPicker %:p:h<CR>")
u.map("n", "<Leader>n", ":NnnPicker")
