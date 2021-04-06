local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local u = require("utils")

telescope.setup {defaults = {mappings = {i = {["<Esc>"] = actions.close}}}}

function _G.grep_prompt()
    builtin.grep_string {
        vimgrep_arguments = u.concat(conf.vimgrep_arguments,
                                     {"--hidden", "-g", "!{node_modules,.git}"}),
        shorten_path = true,
        search = vim.fn.input("grep: ")
    }
end

-- fzf-like aliases
vim.cmd("command! Files Telescope git_files")
vim.cmd("command! BLines Telescope current_buffer_fuzzy_find")
vim.cmd("command! History Telescope oldfiles")
vim.cmd("command! Buffers Telescope buffers")
vim.cmd("command! Rg lua grep_prompt()")
vim.cmd("command! LspRef Telescope lsp_references")
vim.cmd("command! LspSym Telescope lsp_workspace_symbols")
-- unmapped
vim.cmd("command! BCommits Telescope git_bcommits")
vim.cmd("command! Commits Telescope git_commits")
vim.cmd("command! LspAct Telescope lsp_code_actions")

vim.api.nvim_set_keymap("n", "<Leader>ff", "<cmd>Files<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fg", "<cmd>Rg<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fb", "<cmd>Buffers<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fh", "<cmd>History<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fl", "<cmd>BLines<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fr", "<cmd>LspRef<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fs", "<cmd>LspSym<CR>", {silent = true})

vim.api.nvim_set_keymap("n", "<Leader>ga", "<cmd>LspAct<CR>", {silent = true})
