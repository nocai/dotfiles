local u = require("utils")
local commands = require("commands")

-- replace current buffer with selected
local breplace = function(names)
    commands.bdelete()
    for _, name in ipairs(names) do
        vim.cmd("e " .. name)
    end
end

-- delete all buffers and open selected
local bonly = function(names)
    commands.bwipeall()
    for _, name in ipairs(names) do
        vim.cmd("e " .. name)
    end
end

-- open file and test file in split
local split_test_file = function(names)
    vim.cmd("e " .. names[1])
    commands.edit_test_file("Vsplit", function()
        vim.cmd("wincmd w")
    end)
end

vim.g.fzf_action = {
    enter = "edit",
    ["ctrl-v"] = "Vsplit",
    ["ctrl-t"] = "tabedit",
    ["ctrl-r"] = breplace,
    ["ctrl-f"] = split_test_file,
    ["ctrl-x"] = bonly,
}
vim.g.fzf_layout = { window = { width = 0.90, height = 0.90, highlight = "Comment" } }
vim.g.fzf_preview_window = { "up:50%", "ctrl-/" }

-- make :Rg search file contents only, not name
vim.cmd(
    [[command! -bang -nargs=* Rg call fzf#vim#grep("rg --hidden --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)]]
)

u.map("n", "<Leader>ff", ":Files<CR>")
u.map("n", "<Leader>fb", ":Buffers<CR>")
u.map("n", "<Leader>fl", ":BLines<CR>")
u.map("n", "<Leader>fg", ":Rg<CR>")
u.map("n", "<Leader>fh", ":History<CR>")
u.map("n", "<Leader>fc", ":BCommits<CR>")

-- use fzf for completion
u.map("i", "<C-x><C-f>", "<Plug>(fzf-complete-path)", { noremap = false })
u.map("i", "<C-x><C-l>", "<Plug>(fzf-complete-line)", { noremap = false })
u.map("i", "<C-x><C-k>", "<Plug>(fzf-complete-word)", { noremap = false })
