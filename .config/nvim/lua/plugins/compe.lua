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

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return vim.fn["compe#confirm"]()
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t("<Plug>(vsnip-expand-or-jump)")
    else
        return t("<Tab>")
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})

local npairs = require("nvim-autopairs")
OnEnter = function()
    if vim.fn.pumvisible() == 1 then
        return vim.fn["compe#confirm"]()
    else
        return npairs.check_break_line_char()
    end
end
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.OnEnter()", {expr = true})

vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()",
                        {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-y>", "compe#confirm(\"<C-y>\")",
                        {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close(\"<C-e>\")",
                        {expr = true, silent = true})
