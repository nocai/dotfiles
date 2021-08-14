local u = require("utils")

vim.g.mapleader = ","

vim.opt.completeopt = { "menuone", "noinsert" }
vim.opt.hidden = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.shiftwidth = 4
vim.opt.showcmd = false
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.statusline = [[%f %y %m %= %p%% %l:%c]]
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.directory = "/tmp"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 2
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.shortmess:append("cA")
vim.opt.clipboard:append("unnamedplus")

-- the only way I've found to make this persistent
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

_G.global = {}

-- maps
-- \ to go to previous match
u.map("n", "\\", ",")

-- edit file from current file's path
u.map("n", "<Leader>ee", ":edit <C-r>=expand('%:p')<CR>", { silent = false })
u.map("n", "<Leader>ev", ":Vsplit <C-r>=expand('%:p')<CR>", { silent = false })

-- terminal
u.map("n", "<Leader>T", ":term<CR>")
u.map("t", "<C-o>", "<C-\\><C-n>")

-- tabpages
u.map("n", "<Leader>cn", ":tabnew<CR>")
u.map("n", "<Leader>cx", ":tabclose<CR>")
u.map("n", "<Leader>co", ":tabonly<CR>")

-- make useless keys useful
u.map("n", "<BS>", "<C-^>")

u.map("n", "<Esc>", ":nohl<CR>")

u.map("n", "<Tab>", "%", { noremap = false })
u.map("x", "<Tab>", "%", { noremap = false })
u.map("o", "<Tab>", "%", { noremap = false })

u.map("i", "<S-Tab>", "<Esc>A")
u.map("n", "<S-CR>", ":wqall<CR>")

u.map("n", "H", "^")
u.map("o", "H", "^")
u.map("x", "H", "^")
u.map("n", "L", "$")
u.map("o", "L", "$")
u.map("x", "L", "$")

u.map("i", "<M-h>", "<Left>")
u.map("i", "<M-j>", "<Down>")
u.map("i", "<M-k>", "<Up>")
u.map("i", "<M-l>", "<Right>")

u.map("n", "<Space>", ":", { silent = false })
u.map("v", "<Space>", ":", { silent = false })

u.map("n", "q", ":close<CR>")
u.map("n", "Q", "q")

-- misc
u.map("v", ">", ">gv")
u.map("v", "<", "<gv")

u.map("i", "jk", "<Esc>")
u.map("i", "kj", "<Esc>")

u.map("n", "Y", "y$")

u.map("n", "n", "nzz")
u.map("n", "N", "Nzz")

-- expand and indent pair
u.map("i", "(;", "{<CR>}<C-c>O")
u.map("i", "{;", "{<CR>}<C-c>O")
u.map("i", "[;", "{<CR>}<C-c>O")

-- automatically add jumps > 1 to jump list
u.map("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'k'"]], { expr = true })
u.map("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'j'"]], { expr = true })

-- source remaining config
require("commands")
require("plugins")
require("theme")
require("lsp")
