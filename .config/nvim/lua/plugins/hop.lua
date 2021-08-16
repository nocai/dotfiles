local u = require("utils")

require("hop").setup()

u.map("n", "<Space><Space>", ":HopWord<CR>")
u.map("o", "<Space><Space>", ":HopWord<CR>")
-- command doesn't work in visual mode
u.map("v", "<Space><Space>", "<cmd> lua require('hop').hint_words()<CR>")

u.map("n", "<Leader><Leader>", ":HopChar1<CR>")
u.map("o", "<Leader><Leader>", ":HopChar1<CR>")
u.map("v", "<Leader><Leader>", "<cmd> lua require('hop').hint_char1()<CR>")
