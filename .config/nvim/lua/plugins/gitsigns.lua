local u = require("utils")

require("gitsigns").setup({ numhl = true })

u.map("n", "<Leader>hl", ":lua require'gitsigns'.toggle_linehl()<CR>")
u.map("n", "<Leader>hw", ":lua require'gitsigns'.toggle_word_diff()<CR>")
