local u = require("utils")

vim.g.matchup_matchparen_offscreen = { method = "popup", border = true }
vim.g.matchup_surround_enabled = true
vim.g.matchup_matchparen_deferred = true

u.map("o", "i<Tab>", "<Plug>(matchup-i%)", { noremap = false })
u.map("x", "i<Tab>", "<Plug>(matchup-i%)", { noremap = false })
u.map("o", "a<Tab>", "<Plug>(matchup-a%)", { noremap = false })
u.map("x", "a<Tab>", "<Plug>(matchup-a%)", { noremap = false })
