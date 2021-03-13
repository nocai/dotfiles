vim.api.nvim_set_var("sneak#label", true)
vim.api.nvim_set_var("sneak#use_ic_scs", true)

vim.api.nvim_set_keymap("n", "s", "<Plug>Sneak_s", {})
vim.api.nvim_set_keymap("n", "S", "<Plug>Sneak_S", {})
vim.api.nvim_set_keymap("o", "z", "<Plug>Sneak_s", {})
vim.api.nvim_set_keymap("o", "Z", "<Plug>Sneak_S", {})
vim.api.nvim_set_keymap("o", "Z", "<Plug>Sneak_S", {})

vim.api.nvim_set_keymap("n", ",,", "<Plug>Sneak_,", {})
