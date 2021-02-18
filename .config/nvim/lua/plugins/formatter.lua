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
local trim_whitespace = function()
    return {exe = "awk", args = {[['{ sub(/[ \t]+$/, ""); print }']]}}
end

local filetype = {
    typescript = {prettier},
    typescriptreact = {prettier},
    lua = {lua_format},
    tmux = {trim_whitespace},
    zsh = {trim_whitespace}
}

require("formatter").setup({logging = false, filetype = filetype})

local to_string = function(tab)
    local string = ""
    for k, _ in pairs(tab) do string = string .. k .. "," end
    return string
end

vim.api.nvim_exec([[
    augroup FormatOnSave
      autocmd FileType ]] .. to_string(filetype) .. [[
      autocmd! BufWritePost <buffer> FormatWrite
    augroup END
]], true)
