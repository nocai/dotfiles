local dap = require("dap")

dap.adapters = {
    node = {
        type = "executable",
        command = "node",
        args = {
            os.getenv("HOME") .. "/git/vscode-node-debug2/out/src/nodeDebug.js"
        }
    },
    chrome = {
        type = "executable",
        command = "node",
        args = {
            os.getenv("HOME") ..
                "/git/vscode-chrome-debug/out/src/chromeDebug.js",
            "--remote-debugging-port", "9222"
        }
    }
}

local configs = {
    jestDebug = {
        name = "jest-debug",
        type = "node",
        request = "launch",
        cwd = vim.fn.getcwd(),
        runtimeArgs = {"--inspect-brk", "node_modules/.bin/jest", "${file}"},
        protocol = "inspector",
        console = "integratedTerminal",
        port = 9229
    },
    nestAttach = {
        type = "node",
        request = "attach",
        name = "nestjs-attach",
        port = 9229,
        restart = true,
        stopOnEntry = false,
        protocol = "inspector",
        console = "integratedTerminal"
    },
    nestLaunch = {
        type = "node",
        request = "launch",
        name = "nestjs-launch",
        cwd = vim.fn.getcwd(),
        args = {"src/main.ts"},
        runtimeArgs = {
            "--nolazy", "-r", "ts-node/register", "-r",
            "tsconfig-paths/register"
        },
        sourceMaps = true,
        envFile = ".env",
        console = "integratedTerminal",
        protocol = "inspector"
    },
    chrome = {
        type = "chrome",
        request = "launch",
        name = "chrome-debug",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        sourceMaps = true
    }
}

dap.configurations = {
    typescript = {
        configs.nestAttach, configs.nestLaunch, configs.jestDebug,
        configs.chrome
    },
    typescriptreact = {configs.chrome}
}

vim.cmd("command! DapContinue lua require'dap'.continue()")
vim.cmd("command! DapBreakpoint lua require'dap'.toggle_breakpoint()")
vim.cmd("command! DapRepl lua require'dap'.repl.open()")
vim.cmd("command! DapScopes lua require'dap.ui.variables'.scopes()")
vim.cmd("command! DapHover lua require'dap.ui.variables'.visual_hover()")
vim.cmd("command! DapStepOut lua require'dap'.step_out()")
vim.cmd("command! DapStepOver lua require'dap'.step_over()")
vim.cmd("command! DapStepInto lua require'dap'.step_into()")

vim.api.nvim_set_keymap("n", "<Leader>dc", ":DapContinue<CR>", {silent = true})
vim.api
    .nvim_set_keymap("n", "<Leader>db", ":DapBreakpoint<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dr", ":DapRepl<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dh", ":DapHover<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dso", ":DapStepOut<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dsi", ":DapStepInto<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<Leader>dss", ":DapStepOver<CR>", {silent = true})
