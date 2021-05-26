local null_ls = require("null-ls")

local prettier = null_ls.builtins.formatting.prettier
prettier.filetypes = {"html", "json", "yaml", "markdown"}

local sources = {
    null_ls.builtins.formatting.lua_format,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.diagnostics.markdownlint, prettier
}

local M = {}
M.setup = function(on_attach)
    null_ls.setup {on_attach = on_attach, sources = sources}
end

return M
