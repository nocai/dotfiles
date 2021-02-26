local dap = require("dap")

dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/git/vscode-node-debug2/out/src/nodeDebug.js"}
}

local node2 = {
    type = "node2",
    request = "attach",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9229
}

dap.configurations.typescript = {node2}

vim.api.nvim_set_var("dap_virtual_text", true)

_G.dap_attach = function()
    print("attaching")
    require("dap").continue()
end
vim.cmd("command! DapAttach v:lua.dap_attach()")

vim.cmd("command! DapBreakpoint lua require'dap'.toggle_breakpoint()")
vim.cmd("command! DapRepl lua require'dap'.repl.open()")
vim.cmd("command! DapScopes lua require'dap.ui.variables'.scopes()")
vim.cmd("command! DapHover lua require'dap.ui.variables'.visual_hover()")
vim.cmd("command! DapStepOut lua require'dap'.step_out()")
vim.cmd("command! DapStepOver lua require'dap'.step_over()")
vim.cmd("command! DapStepInto lua require'dap'.step_into()")

vim.api
    .nvim_set_keymap("n", "<Leader>db", ":DapBreakpoint<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dh", ":DapHover<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dso", ":DapStepOut<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dsi", ":DapStepInto<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dss", ":DapStepOver<CR>", {silent = true})
