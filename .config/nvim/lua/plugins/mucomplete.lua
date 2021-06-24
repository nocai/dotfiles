local u = require("utils")

vim.g["mucomplete#no_mappings"] = true
vim.g["mucomplete#enable_auto_at_startup"] = true

_G.global.check_mucomplete = function()
    local banned = { "", "TelescopePrompt" }
    local ft = vim.bo.filetype

    if vim.tbl_contains(banned, ft) then
        vim.cmd("MUcompleteAutoOff")
        return
    end

    vim.cmd("MUcompleteAutoOn")
end

u.augroup("CheckMucomplete", "BufEnter", "lua global.check_mucomplete()")
