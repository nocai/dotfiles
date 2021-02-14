local actions = require("telescope.actions")
local utils = require("utils")
local cmd = utils.cmd
local map = utils.map

require("telescope").setup {
    defaults = {
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case", "--hidden"
        },
        mappings = {i = {["<Esc>"] = actions.close}}
    }
}

function _G.find_files()
    require"telescope.builtin".find_files(
        {find_command = {"rg", "--files", "--hidden"}})
end

-- fzf-like aliases
cmd("command! Files lua find_files()")
cmd("command! BLines Telescope current_buffer_fuzzy_find")
cmd("command! History Telescope oldfiles")
cmd("command! Buffers Telescope buffers")
cmd("command! Rg Telescope live_grep")
cmd("command! LspRef Telescope lsp_references")
cmd("command! LspSym Telescope lsp_workspace_symbols")
-- unmapped
cmd("command! BCommits Telescope git_bcommits")
cmd("command! Commits Telescope git_commits")
cmd("command! LspAct Telescope lsp_code_actions")

map("n", "<Leader>ff", "<cmd>Files<CR>", {silent = true})
map("n", "<Leader>fg", "<cmd>Rg<CR>", {silent = true})
map("n", "<Leader>fb", "<cmd>Buffers<CR>", {silent = true})
map("n", "<Leader>fh", "<cmd>History<CR>", {silent = true})
map("n", "<Leader>fl", "<cmd>BLines<CR>", {silent = true})
map("n", "<Leader>fr", "<cmd>LspRef<CR>", {silent = true})
map("n", "<Leader>fs", "<cmd>LspSym<CR>", {silent = true})
