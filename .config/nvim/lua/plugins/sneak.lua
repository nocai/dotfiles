vim.g["sneak#label"] = true
vim.g["sneak#use_ic_scs"] = true
vim.g["sneak#s_next"] = true

vim.api.nvim_set_keymap("n", "s", "<Plug>Sneak_s", {})
vim.api.nvim_set_keymap("n", "S", "<Plug>Sneak_S", {})
vim.api.nvim_set_keymap("o", "z", "<Plug>Sneak_s", {})
vim.api.nvim_set_keymap("o", "Z", "<Plug>Sneak_S", {})

vim.api.nvim_set_keymap("n", "f", "<Plug>Sneak_f", {})
vim.api.nvim_set_keymap("n", "F", "<Plug>Sneak_F", {})
vim.api.nvim_set_keymap("o", "f", "<Plug>Sneak_f", {})
vim.api.nvim_set_keymap("o", "F", "<Plug>Sneak_F", {})

vim.api.nvim_set_keymap("n", "t", "<Plug>Sneak_t", {})
vim.api.nvim_set_keymap("n", "T", "<Plug>Sneak_T", {})
vim.api.nvim_set_keymap("o", "t", "<Plug>Sneak_t", {})
vim.api.nvim_set_keymap("o", "T", "<Plug>Sneak_T", {})
