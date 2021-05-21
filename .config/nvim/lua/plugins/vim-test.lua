local u = require("utils")

vim.g["test#strategy"] = "basic"

u.define_command("TestCoverage", "term npm run test:cov")

u.map("n", "<Leader>te", ":TestNearest<CR>")
u.map("n", "<Leader>tf", ":TestFile<CR>")
u.map("n", "<Leader>ts", ":TestSuite<CR>")
u.map("n", "<Leader>tc", ":TestCoverage<CR>")
