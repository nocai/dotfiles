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

vim.api.nvim_set_keymap("n", "<Leader>db",
                        ":lua require'dap'.toggle_breakpoint()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dc", ":lua require'dap'.continue()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dr", ":lua require'dap'.repl.open()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dp",
                        ":lua require'dap.ui.variables'.scopes()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dv",
                        ":lua require'dap.ui.variables'.visual_hover()<CR>",
                        {silent = true})

vim.api.nvim_set_keymap("n", "<Leader>dso", ":lua require'dap'.step_out()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dsi", ":lua require'dap'.step_into()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dss", ":lua require'dap'.step_over()<CR>",
                        {silent = true})
