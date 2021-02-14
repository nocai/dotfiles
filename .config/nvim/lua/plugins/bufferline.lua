local map = require("utils").map

require("bufferline").setup {
    options = {
        show_buffer_close_icons = false,
        separator_style = "thin",
        always_show_bufferline = true
    },
    highlights = {buffer_selected = {gui = "bold"}}
}

map("n", "[b", ":BufferLineCyclePrev<CR>", {silent = true})
map("n", "]b", ":BufferLineCycleNext<CR>", {silent = true})
map("n", "[B", ":BufferLineMovePrev<CR>", {silent = true})
map("n", "]B", ":BufferLineMoveNext<CR>", {silent = true})
map("n", "gb", ":BufferLinePick<CR>", {silent = true})
