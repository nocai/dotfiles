local u = require("utils")

require("neogit").setup({ integrations = { diffview = true, disable_commit_confirmation = true } })

u.map("n", "<Leader>g", ":Neogit<CR>")
