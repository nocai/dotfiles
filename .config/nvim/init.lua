local u = require("utils")

-- options
vim.g.mapleader = ","
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.hidden = true
vim.o.completeopt = "menuone,noselect"
vim.o.pumheight = 10
vim.o.statusline = [[%f %y %m %= %p%% %l:%c]]
vim.o.showtabline = 2
vim.o.foldlevelstart = 99

-- vim.bo isn't working; investigate
vim.cmd("set undofile")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.wo.signcolumn = "yes"

-- not sure how to set this without vim.cmd
vim.cmd("set shortmess+=c")

-- autocommands and commands
vim.cmd("command! Bd %bd")
vim.cmd("command! Bo %bd|e#")

function _G.HighlightOnYank()
    vim.highlight.on_yank {higroup = "IncSearch", timeout = 500}
end
u.exec([[
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua HighlightOnYank()
augroup END
]])

-- restarts lsp and treesitter
vim.cmd("command! R w | :e")

-- bindings
u.map("n", "H", "^")
u.map("o", "H", "^")
u.map("x", "H", "^")
u.map("n", "L", "$")
u.map("o", "L", "$")
u.map("x", "L", "$")

u.map("n", "<C-n>", ":bprev<CR>", {silent = true})
u.map("n", "<C-p>", ":bnext<CR>", {silent = true})

u.map("n", "<Space>", ":")
u.map("v", "<Space>", ":")

u.map("n", "<Tab>", "%")
u.map("x", "<Tab>", "%")
u.map("o", "<Tab>", "%")

u.map("i", "<C-h>", "<Left>")
u.map("i", "<C-j>", "<Down>")
u.map("i", "<C-k>", "<Up>")
u.map("i", "<C-l>", "<Right>")

u.map("n", "<BS>", "<C-^>")
u.map("n", "Y", "y$")
u.map("n", "mm", "m'")
u.map("n", "<Bslash>", ",")
u.map("n", "<Leader>x", ":bd<CR>", {silent = true})
u.map("n", "<Esc>", ":nohl<CR>", {silent = true})
-- restarts lsp

-- save w/ <CR> in non-quickfix buffers
u.map("n", "<CR>", "(&buftype is# 'quickfix' ? '<CR>' : ':w<CR>')",
      {expr = true})

-- load remaining lua config
if (u.config_file_exists("theme.lua")) then require("theme") end
if (u.config_file_exists("plugins/init.lua")) then require("plugins") end
if (u.config_file_exists("lsp/init.lua")) then require("lsp") end
