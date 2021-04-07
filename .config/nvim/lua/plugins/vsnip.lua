vim.g.vsnip_filetypes = {
    javascriptreact = {"javascript"},
    typescriptreact = {"typescript"}
}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t("<C-y>")
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t("<Plug>(vsnip-expand-or-jump)")
    else
        return t("<C-x><C-o>")
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})

vim.api
    .nvim_set_keymap("n", "<Leader>V", ":VsnipOpenSplit<CR>", {silent = true})
