local map = require("utils").map

require"compe".setup {
    source = {
        path = true,
        buffer = true,
        vsnip = true,
        nvim_lsp = true,
        nvim_lua = true
    }
}

map("i", "<C-Space>", "compe#complete()", {expr = true, silent = true})
map("i", "<C-y>", "compe#confirm(\"<C-y>\")", {expr = true, silent = true})
map("i", "<C-e>", "compe#confirm(\"<C-e>\")", {expr = true, silent = true})
