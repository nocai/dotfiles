local u = require("utils")

u.map("n", "<A-n>", "<cmd>lua require'illuminate'.next_reference{wrap=true}<CR>")
u.map("n", "<A-N>",
      "<cmd>lua require'illuminate'.next_reference{reverse=true,wrap=true}<CR>")
