local actions = require("telescope.actions")

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
vim.cmd("command! Files lua find_files()")
vim.cmd("command! BLines Telescope current_buffer_fuzzy_find")
vim.cmd("command! History Telescope oldfiles")
vim.cmd("command! Buffers Telescope buffers")
vim.cmd("command! Rg Telescope live_grep")
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
