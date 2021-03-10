local M = {}

M.root = vim.fn.getenv("HOME") .. "/git/lua-language-server/"
M.binary = M.root .. "/bin/macOS/lua-language-server"
M.settings = {
    Lua = {
        diagnostics = {
            enable = true,
            globals = {"vim", "use", "describe", "it", "assert"}
        }
    }
}

return M
