if vim.api.nvim_eval("exists('g:vscode')") == 0 then vim.g["sneak#label"] = true end
vim.g["sneak#use_ic_scs"] = true

vim.api.nvim_set_keymap("", "f", "<Plug>Sneak_s", {})
vim.api.nvim_set_keymap("", "f", "<Plug>Sneak_s", {})
vim.api.nvim_set_keymap("", "t", "<Plug>Sneak_t", {})
vim.api.nvim_set_keymap("", "T", "<Plug>Sneak_T", {})
