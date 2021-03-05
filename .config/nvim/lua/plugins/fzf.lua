vim.g.fzf_layout = {window = {width = 0.9, height = 0.8, highlight = "Comment"}}

vim.g.fzf_preview_window = {"up:60%", "ctrl-/"}
-- make :Rg search file contents only, not name
vim.cmd(
    [[command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)]])

vim.api.nvim_set_keymap("n", "<Leader>ff", ":Files<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fb", ":Buffers<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fl", ":BLines<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fg", ":Rg<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fh", ":History<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>fc", ":BCommits<CR>", {silent = true})
