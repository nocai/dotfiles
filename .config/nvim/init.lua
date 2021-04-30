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
vim.cmd("command! Bd %bd")
vim.cmd("command! Bo %bd|e#|bd#")
vim.cmd("command! R w | :e")
vim.cmd("command! Remove call delete(expand('%')) | bdelete!")
vim.cmd("command! Git startinsert | term lazygit")

u.exec([[
augroup FixFormatOpts
    autocmd!
    autocmd BufEnter * setlocal formatoptions=jql
augroup END
]])

_G.on_term_close = function()
    if not string.match(vim.fn.expand("<afile>"), "nnn") then
        vim.api.nvim_input("<CR>")
    end
end

u.exec([[
augroup TermOpts
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermClose * lua on_term_close()
augroup END
]])

function _G.HighlightOnYank()
    vim.highlight.on_yank {higroup = "IncSearch", timeout = 500}
end

u.exec([[
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua HighlightOnYank()
augroup END
]])

-- automatically create non-existent directories on :e
u.exec([[
augroup CreateDirectory
    autocmd!
    autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
augroup END
]])

-- maps
u.map("o", "ae", ":<C-u>normal! ggVG<CR>")

u.map("i", "<S-Tab>", "<C-o>A")

u.map("n", "H", "^")
u.map("o", "H", "^")
u.map("x", "H", "^")
u.map("n", "L", "$")
u.map("o", "L", "$")
u.map("x", "L", "$")

u.map("n", "<Leader>b", ":Bo<CR>")
u.map("n", "<Leader>B", ":Bd<CR>")

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
if (u.config_file_exists("plugins/init")) then require("plugins") end
if (u.config_file_exists("theme")) then require("theme") end
if (u.config_file_exists("lsp/init")) then require("lsp") end
