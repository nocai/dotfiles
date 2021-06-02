local u = require("utils")

vim.g.mapleader = ","

vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noinsert" }
vim.opt.expandtab = true
vim.opt.foldlevelstart = 99
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.shiftwidth = 4
vim.opt.shortmess:append("cA")
vim.opt.showcmd = false
vim.opt.showtabline = 2
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.statusline = [[%f %y %m %= %p%% %l:%c]]
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- maps
u.map("o", "ae", ":<C-u>normal! ggVG<CR>")

u.map("i", "<S-Tab>", "<C-o>A")

u.map("n", "H", "^")
u.map("o", "H", "^")
u.map("x", "H", "^")
u.map("n", "L", "$")
u.map("o", "L", "$")
u.map("x", "L", "$")

u.map("t", "<C-o>", "<C-\\><C-n>")

u.map("n", "<Space>", ":", { silent = false })
u.map("v", "<Space>", ":", { silent = false })

u.map("n", "<Tab>", "%", { noremap = false })
u.map("x", "<Tab>", "%", { noremap = false })
u.map("o", "<Tab>", "%", { noremap = false })

u.map("n", "<BS>", "<C-^>")
u.map("n", "Y", "y$")
u.map("n", "<Esc>", ":nohl<CR>")

-- automatically add jumps > 1 to jump list
u.map("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'k'"]], { expr = true })
u.map("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'j'"]], { expr = true })

-- load remaining lua config
_G.global = {}
require("commands")
require("plugins")
require("theme")
require("lsp")
require("ft")
