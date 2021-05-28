local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.formatting.prettier.with(
        {filetypes = {"html", "json", "yaml", "markdown"}}),
    null_ls.builtins.formatting.lua_format.with({timeout = 5000}),
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.diagnostics.markdownlint
}

local M = {}
M.setup = function(on_attach)
    null_ls.setup {on_attach = on_attach, sources = sources}
end

return M
