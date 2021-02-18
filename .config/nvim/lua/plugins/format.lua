local prettier = function()
    return {
        exe = "prettier",
        args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        stdin = true
    }
end
local lua_format = function()
    return {
        exe = "lua-format",
        args = {"--single-quote-to-double-quote", "-i"},
        stdin = true
    }
end

require("formatter").setup({
    logging = false,
    filetype = {
        typescript = {prettier},
        typescriptreact = {prettier},
        lua = {lua_format}
    }
})

vim.api.nvim_exec([[
    augroup FormatOnSave
      autocmd!
      autocmd BufWritePost *.ts,*.tsx,*.lua FormatWrite
    augroup END
]], true)
