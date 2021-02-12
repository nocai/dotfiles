local root = vim.fn.getenv("HOME") .. "/git/lua-language-server/"
local binary = root .. "/bin/macOS/lua-language-server"

return {root = root, binary = binary}
