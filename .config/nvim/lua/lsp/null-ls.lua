local null_ls = require("null-ls")

local sources = {null_ls.builtins.markdown.write_good}

local M = {}
M.setup = function(on_attach)
    null_ls.setup {on_attach = on_attach, sources = sources}
end

return M
