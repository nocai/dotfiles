local u = require("utils")

u.map("n", "<C-n>", "<cmd>lua require'illuminate'.next_reference{wrap=true}<CR>")
u.map("n", "<C-p>",
      "<cmd>lua require'illuminate'.next_reference{reverse=true,wrap=true}<CR>")
