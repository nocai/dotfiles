require"compe".setup {
    preselect = "always",
    source = {
        path = true,
        buffer = true,
        vsnip = {priority = 9999},
        nvim_lsp = true,
        nvim_lua = true
    }
}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t("<C-n>")
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t("<Plug>(vsnip-expand-or-jump)")
    elseif check_back_space() then
        return t("<Tab>")
    else
        return vim.fn["compe#complete"]()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t("<C-p>")
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t("<Plug>(vsnip-jump-prev)")
    else
        return t("<C-o>A")
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

local npairs = require("nvim-autopairs")
OnEnter = function()
    if vim.fn.pumvisible() == 1 then
        return vim.fn["compe#confirm"]()
    else
        return npairs.check_break_line_char()
    end
end
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.OnEnter()",
                        {expr = true, noremap = true})

vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()",
                        {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-y>", "compe#confirm(\"<C-y>\")",
                        {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-e>", "compe#confirm(\"<C-e>\")",
                        {expr = true, silent = true})
