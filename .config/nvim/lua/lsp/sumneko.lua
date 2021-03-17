local u = require("utils")
local M = {}

M.root = vim.fn.getenv("HOME") .. "/git/lua-language-server/"
M.binary =
    u.get_os() == "Linux" and M.root .. "/bin/Linux/lua-language-server" or
        u.get_os() == "Darwin" and "/bin/macOS/lua-language-server"
M.settings = {
    Lua = {
        diagnostics = {
            enable = true,
            globals = {"vim", "use", "describe", "it", "assert"}
        }
    }
}

return M
