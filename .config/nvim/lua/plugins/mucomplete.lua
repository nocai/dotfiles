vim.api.nvim_set_var("mucomplete#enable_auto_at_startup", true)
vim.api.nvim_set_var("mucomplete#no_mappings", true)

vim.api.nvim_exec([[
let g:mucomplete#can_complete = {}
let g:mucomplete#can_complete.default = { 'omni': { t -> t =~# '\m\k\%(\k\|\.\)$' } }

let g:mucomplete#chains = {'default' : ['vsnip', 'omni', 'path', 'keyn', 'dict', 'uspl'] }
]], true)

