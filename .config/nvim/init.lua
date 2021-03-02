local u = require("utils")

-- options
vim.g.mapleader = ","
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.shortmess = "filnxtToOFcA"
vim.o.showcmd = false

if not (u.in_vscode()) then
    vim.o.mouse = "a"
    vim.o.splitbelow = true
    vim.o.splitright = true
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.wo.cursorline = true
    vim.wo.signcolumn = "yes"
    vim.o.showtabline = 2
    vim.o.showtabline = 2
    vim.o.backup = false
    vim.o.writebackup = false
    vim.o.updatetime = 300
    vim.o.hidden = true
    vim.o.completeopt = "menuone,noselect"
    vim.o.pumheight = 10
    vim.o.termguicolors = true
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.expandtab = true
    vim.o.statusline = [[%f %y %m %= %p%% %l:%c]]

    u.map("i", "<S-Tab>", "<C-o>A")
    if (u.config_file_exists("theme.lua")) then require("theme") end
end

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

u.map("n", "<BS>", "<C-^>")
u.map("n", "Y", "y$")
u.map("n", ",,", ",")
u.map("n", "<Esc>", ":nohl<CR>", {silent = true})

_G.close_buffer = function()
    if (u.in_vscode()) then
        return vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
    else
        return vim.cmd("bd")
    end
end
u.map("n", "<Leader>x", "<cmd> lua close_buffer()<CR>", {silent = true})

_G.save_on_enter = function()
    if (u.in_vscode()) then
        return vim.fn.VSCodeNotify("workbench.action.files.save")
    else
        return vim.cmd("w")
    end
end
u.map("n", "<CR>", "<cmd> lua save_on_enter()<CR>", {silent = true})

_G.file_picker = function()
    if (u.in_vscode()) then
        return vim.fn.VSCodeNotify("workbench.action.quickOpen")
    else
        return vim.cmd("Files")
    end
end
u.map("n", "<Leader>f", "<cmd> lua file_picker()<CR>", {silent = true})

if (u.in_vscode()) then
    u.map("n", "<Leader>c",
          "<cmd> call VSCodeNotify('workbench.action.showCommands')<CR>",
          {silent = true})
end

-- add jumps > 1 to jump list
u.map("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'k'"]], {expr = true})
u.map("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'j'"]], {expr = true})

if (u.config_file_exists("plugins/init.lua")) then require("plugins") end
