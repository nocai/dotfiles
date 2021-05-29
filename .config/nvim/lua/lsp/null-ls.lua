local null_ls = require("null-ls")
local builtins = null_ls.builtins

local sources = {
    builtins.formatting.prettier.with({
        filetypes = {"html", "json", "yaml", "markdown"}
    }), builtins.formatting.lua_format,
    builtins.formatting.trailing_whitespace.with({filetypes = {"tmux", "fish"}}),
    builtins.diagnostics.write_good, builtins.diagnostics.markdownlint,
    builtins.diagnostics.teal
}

local M = {}
M.setup = function(on_attach)
    null_ls.setup {on_attach = on_attach, sources = sources}
end

return M
