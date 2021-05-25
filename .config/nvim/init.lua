local u = require("utils")

vim.g.mapleader = ","

vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noinsert"
vim.o.expandtab = true
vim.o.foldlevelstart = 99
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.mouse = "a"
vim.o.pumheight = 10
vim.o.shiftwidth = 4
vim.o.shortmess = "filnxtToOFcA"
vim.o.showcmd = false
vim.o.showtabline = 2
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statusline = [[%f %y %m %= %p%% %l:%c]]
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 300

vim.wo.cursorline = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"

-- (auto)commands
vim.cmd("command! Bd %bw")
vim.cmd("command! Bo %bd|e#|bd#")
u.map("n", "<Leader>b", ":Bo<CR>")
u.map("n", "<Leader>B", ":Bd<CR>")

vim.cmd("command! R w | :e")
vim.cmd("command! Remove call delete(expand('%')) | bdelete!")

u.define_augroup("FixFormatOpts", "BufEnter", "setlocal formatoptions=jql")

_G.on_term_close = function()
    if not string.match(vim.fn.expand("<afile>"), "nnn") then
        vim.api.nvim_input("<CR>")
    end
end
u.define_augroup("OnTermOpen", "TermOpen", "setlocal nonumber norelativenumber")
u.define_augroup("OnTermClose", "TermClose", "lua on_term_close()")

u.define_augroup("Fish", "BufEnter", "set filetype=fish", "*.fish")

function _G.yank_highlight()
    vim.highlight.on_yank {higroup = "IncSearch", timeout = 500}
end
u.define_augroup("YankHighlight", "TextYankPost", "lua yank_highlight()")

-- automatically create non-existent directories on :e
u.define_augroup("CreateDirectory", "BufWritePre,FileWritePre",
                 "call mkdir(expand('<afile>:p:h'), 'p')")

-- maps
-- define ae as entire document text object
u.map("o", "ae", ":<C-u>normal! ggVG<CR>")

u.map("i", "<S-Tab>", "<C-o>A")

u.map("n", "<S-CR>", ":wqall<CR>")

u.map("n", "H", "^")
u.map("o", "H", "^")
u.map("x", "H", "^")
u.map("n", "L", "$")
u.map("o", "L", "$")
u.map("x", "L", "$")

u.map("t", "<C-o>", "<C-\\><C-n>")

u.map("n", "<Space>", ":", {silent = false})
u.map("v", "<Space>", ":", {silent = false})

u.map("n", "<Tab>", "%", {noremap = false})
u.map("x", "<Tab>", "%", {noremap = false})
u.map("o", "<Tab>", "%", {noremap = false})

u.map("n", "<BS>", "<C-^>")
u.map("n", "Y", "y$")
u.map("n", "<Esc>", ":nohl<CR>", {silent = true})
u.map("n", "<Leader>cc", ":bd<CR>", {silent = true})

-- save w/ <CR> in non-quickfix buffers
u.map("n", "<CR>", "(&buftype is# 'quickfix' ? '<CR>' : ':w<CR>')",
      {expr = true})

-- automatically add jumps > 1 to jump list
u.map("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'k'"]], {expr = true})
u.map("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'j'"]], {expr = true})

-- load remaining lua config
require("plugins")
require("theme")
require("lsp")
