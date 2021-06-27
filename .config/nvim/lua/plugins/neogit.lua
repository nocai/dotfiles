local u = require("utils")

require("neogit").setup({ integrations = { diffview = true } })

u.map("n", "<Leader>g", ":Neogit<CR>")
