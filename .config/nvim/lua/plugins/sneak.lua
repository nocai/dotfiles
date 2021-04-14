vim.g["sneak#label"] = true
vim.g["sneak#use_ic_scs"] = true
vim.g["sneak#s_next"] = true

vim.api.nvim_set_keymap("n", "f", "<Plug>Sneak_s", {})
vim.api.nvim_set_keymap("n", "F", "<Plug>Sneak_S", {})
vim.api.nvim_set_keymap("o", "f", "<Plug>Sneak_s", {})
vim.api.nvim_set_keymap("o", "F", "<Plug>Sneak_S", {})
