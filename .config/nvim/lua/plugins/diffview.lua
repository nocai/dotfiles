local u = require("utils")

require("diffview").setup({ file_panel = { use_icons = false } })

u.map("n", "<Leader>G", ":DiffviewOpen<CR>")
