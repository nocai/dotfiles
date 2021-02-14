local g = vim.g
local cmd = vim.cmd
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end
local nvim_config_dir = vim.fn.getenv("HOME") .. "/.config/nvim/lua/"

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then scopes["o"][key] = value end
end

return {
    g = g,
    cmd = cmd,
    file_exists = file_exists,
    nvim_config_dir = nvim_config_dir,
    map = map,
    opt = opt
}
