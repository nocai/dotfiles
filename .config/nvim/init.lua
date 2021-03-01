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
vim.o.completeopt = "menuone,noinsert"
vim.o.pumheight = 10
vim.o.showtabline = 2
vim.o.foldlevelstart = 99
vim.o.undofile = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.shortmess = "filnxtToOFcA"
vim.o.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·"

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.wo.signcolumn = "yes"

-- statusline
vim.o.statusline = [[%f %y %m %= %{LspStatus()} %p%% %l:%c]]

-- autocommands and commands
vim.cmd("command! Bd %bd")
vim.cmd("command! Bo %bd|e#")
vim.cmd("command! Remove call delete(expand('%')) | bdelete!")

function _G.HighlightOnYank()
    vim.highlight.on_yank {higroup = "IncSearch", timeout = 500}
end

u.exec([[
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua HighlightOnYank()
augroup END
]])

u.exec([[
augroup CreateDirectory
    autocmd!
    autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
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
u.map("n", "<Bslash>", ",")
u.map("n", "ZZ", ":wqall<CR>")
u.map("n", "<Leader>x", ":bd<CR>", {silent = true})
u.map("n", "<Esc>", ":nohl<CR>", {silent = true})
u.map("i", "<S-Tab>", "<C-o>A")

-- save w/ <CR> in non-quickfix buffers
u.map("n", "<CR>", "(&buftype is# 'quickfix' ? '<CR>' : ':w<CR>')",
      {expr = true})

-- add jumps > 1 to jump list
u.map("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'k'"]], {expr = true})
u.map("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'j'"]], {expr = true})

-- load remaining lua config
if (u.config_file_exists("theme.lua")) then require("theme") end
if (u.config_file_exists("plugins/init.lua")) then
    require("plugins")
    u.map("n", "<Leader>p", ":PackerSync<CR>", {silent = true})
end
if (u.config_file_exists("lsp/init.lua")) then require("lsp") end
