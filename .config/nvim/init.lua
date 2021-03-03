local u = require("utils")

vim.g.mapleader = ","
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.shortmess = "filnxtToOFcA"

if not (u.is_vscode()) then
    vim.o.termguicolors = true
    vim.o.backup = false
    vim.o.writebackup = false
    vim.o.updatetime = 300
    vim.o.splitbelow = true
    vim.o.splitright = true
    vim.o.hidden = true
    vim.o.completeopt = "menuone,noselect"
    vim.o.pumheight = 10
    vim.o.showtabline = 2
    vim.o.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·"
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.expandtab = true
    vim.o.mouse = "a"
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.wo.cursorline = true
    vim.wo.signcolumn = "yes"
    vim.o.statusline = [[%f %y %m %= %p%% %l:%c]]

    u.exec([[
    augroup CreateDirectory
        autocmd!
        autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
    augroup END
    ]])

    u.map("n", "<Leader>ee", ":edit <C-r>=expand('%:h')<CR>/")
    u.map("n", "<Leader>ev", ":vsplit <C-r>=expand('%:h')<CR>/")
    u.map("n", "<Leader>es", ":split <C-r>=expand('%:h')<CR>/")

    u.map("i", "<S-Tab>", "<C-o>A")

    vim.cmd("command! R w | :e")
end

function _G.HighlightOnYank()
    vim.highlight.on_yank {higroup = "IncSearch", timeout = 500}
end

u.exec([[
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua HighlightOnYank()
augroup END
]])

u.map("n", "H", "^")
u.map("o", "H", "^")
u.map("x", "H", "^")
u.map("n", "L", "$")
u.map("o", "L", "$")
u.map("x", "L", "$")

u.map("n", "<Space>", ":")
u.map("v", "<Space>", ":")

u.map("n", "<Tab>", "%", {noremap = false})
u.map("x", "<Tab>", "%", {noremap = false})
u.map("o", "<Tab>", "%", {noremap = false})

u.map("n", "<BS>", "<C-^>")
u.map("n", "Y", "y$")
u.map("n", ",,", ",")
u.map("n", "<Leader>x", ":bd<CR>", {silent = true})
u.map("n", "gR", "gr$")

_G.close_all_buffers = function()
    if (u.is_vscode()) then
        return vim.fn.VSCodeNotify("workbench.action.closeAllGroups")
    else
        return vim.cmd("%bd")
    end
end
vim.cmd("command! Bd lua close_all_buffers()")

_G.only_buffer = function()
    if (u.is_vscode()) then
        return vim.fn.VSCodeNotify("workbench.action.closeOtherEditors")
    else
        return vim.cmd("%bd|e#")
    end
end
vim.cmd("command! Bo lua only_buffer()")

_G.close_buffer = function()
    if (u.is_vscode()) then
        return vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
    else
        return vim.cmd("bd")
    end
end
u.map("n", "<Leader>x", "<cmd> lua close_buffer()<CR>", {silent = true})

_G.save_on_enter = function()
    if (u.is_vscode()) then
        return vim.fn.VSCodeNotify("workbench.action.files.save")
    else
        return vim.cmd("w")
    end
end
u.map("n", "<CR>", "<cmd> lua save_on_enter()<CR>", {silent = true})

_G.file_picker = function()
    if (u.is_vscode()) then
        return vim.fn.VSCodeNotify("workbench.action.quickOpen")
    else
        return vim.cmd("Files")
    end
end
u.map("n", "<Leader>f", "<cmd> lua file_picker()<CR>", {silent = true})

if (u.is_vscode()) then
    -- remove vscode-neovim multiple cursor bindings
    vim.api.nvim_del_keymap("x", "ma")
    vim.api.nvim_del_keymap("x", "mA")
    vim.api.nvim_del_keymap("x", "mi")
    vim.api.nvim_del_keymap("x", "mI")

    u.map("n", "<Leader>c",
          "<cmd> call VSCodeNotify('workbench.action.showCommands')<CR>",
          {silent = true})
    u.map("n", "gs",
          "<cmd> call VSCodeNotify('editor.action.organizeImports')<CR>",
          {silent = true})
end

-- add jumps > 1 to jump list
u.map("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'k'"]], {expr = true})
u.map("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'j'"]], {expr = true})

-- expand current file's directory to quickly edit / create new files
u.map("n", "<Leader>ee", ":edit <C-r>=expand('%:h')<CR>/")
u.map("n", "<Leader>ev", ":vsplit <C-r>=expand('%:h')<CR>/")
u.map("n", "<Leader>es", ":split <C-r>=expand('%:h')<CR>/")

-- load remaining lua config
if (u.config_file_exists("plugins/init.lua")) then require("plugins") end
if not (u.is_vscode()) then
    if (u.config_file_exists("theme.lua")) then require("theme") end
    if (u.config_file_exists("lsp/init.lua")) then require("lsp") end
end
