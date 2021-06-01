local u = require("utils")

local api = vim.api
local fn = vim.fn

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

-- (auto)commands
_G.global = {}

local for_each_buffer = function(cb)
    u.for_each(fn.getbufinfo({ buflisted = true }), function(b)
        if b.changed == 0 then
            cb(b)
        end
    end)
end

local complete_timer
_G.global.commands = {
    bonly = function()
        local current = api.nvim_get_current_buf()
        for_each_buffer(function(b)
            if b.bufnr ~= current then
                vim.cmd("bdelete " .. b.bufnr)
            end
        end)
    end,

    bwipeall = function()
        for_each_buffer(function(b)
            vim.cmd("bdelete " .. b.bufnr)
        end)
    end,

    wwipeall = function()
        local win = api.nvim_get_current_win()
        u.for_each(fn.getwininfo(), function(w)
            if w.winid ~= win then
                if w.loclist == 1 then
                    vim.cmd("lclose")
                elseif w.quickfix == 1 then
                    vim.cmd("cclose")
                else
                    vim.cmd(w.winnr .. " close")
                end
            end
        end)
    end,

    bdelete = function()
        local win = api.nvim_get_current_win()
        local bufnr = api.nvim_win_get_buf(win)

        local target
        local previous = fn.bufnr("#")
        if previous ~= -1 and previous ~= bufnr and fn.buflisted(previous) == 1 then
            target = previous
        end

        if not target then
            for_each_buffer(function(b)
                if not target and b.bufnr ~= bufnr then
                    target = b.bufnr
                end
            end)
        end

        if not target then
            target = api.nvim_create_buf(false, false)
        end

        local windows = fn.getbufinfo(bufnr)[1].windows
        u.for_each(windows, function(w)
            api.nvim_win_set_buf(w, target)
        end)

        vim.cmd("bdelete " .. bufnr)
    end,

    complete = function()
        local filetype = vim.bo.filetype
        if not filetype or filetype == "TelescopePrompt" then
            return
        end

        if complete_timer then
            complete_timer.restart()
            return
        end

        complete_timer = u.timer(100, nil, true, function()
            complete_timer = nil

            if vim.fn.pumvisible() == 1 or vim.fn.mode() ~= "i" then
                return
            end

            local seq = vim.bo.omnifunc ~= "" and filetype ~= "markdown" and "<C-x><C-o>" or "<C-x><C-n>"
            api.nvim_input(seq)
        end)
    end,
}

u.augroup("Autocomplete", "InsertCharPre", "lua global.commands.complete()")

u.lua_command("Bdelete", "global.commands.bdelete()")
u.lua_command("Bwipeall", "global.commands.bwipeall()")
u.lua_command("Wwipeall", "global.commands.wwipeall()")
u.lua_command("Bonly", "global.commands.bonly()")
u.map("n", "<Leader>cc", ":Bdelete<CR>")

u.command("Remove", "call delete(expand('%')) | bdelete!")

function _G.global.yank_highlight()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
end
u.augroup("YankHighlight", "TextYankPost", "lua global.yank_highlight()")

-- automatically create non-existent directories on :e
u.augroup("CreateDirectory", "BufWritePre,FileWritePre", "call mkdir(expand('<afile>:p:h'), 'p')")

-- maps
-- define ae as entire document text object
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

-- save w/ <CR> in non-quickfix buffers
u.map("n", "<CR>", "(&buftype is# 'quickfix' ? '<CR>' : ':w<CR>')", { expr = true })

-- automatically add jumps > 1 to jump list
u.map("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'k'"]], { expr = true })
u.map("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'j'"]], { expr = true })

-- load remaining lua config
require("plugins")
require("theme")
require("lsp")
require("ft")
