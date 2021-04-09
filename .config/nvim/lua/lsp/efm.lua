local tools = {
    eslint = {
        lintCommand = "eslint_d --stdin --stdin-filename ${INPUT} -f unix",
        lintStdin = true,
        lintIgnoreExitCode = true
    },
    prettier = {
        formatCommand = "prettier --stdin-filepath ${INPUT}",
        formatStdin = true
    },
    luaFormat = {
        formatCommand = "lua-format --single-quote-to-double-quote -i",
        formatStdin = true
    },
    markdownlint = {
        lintCommand = "markdownlint -s",
        lintStdin = true,
        lintFormats = {"%f:%l %m", "%f:%l:%c %m", "%f: %l: %m"}
    }
}

local languages = {
    markdown = {tools.markdownlint, tools.prettier},
    javascript = {tools.eslint, tools.prettier},
    javascriptreacat = {tools.eslint, tools.prettier},
    typescript = {tools.eslint, tools.prettier},
    typescriptreact = {tools.eslint, tools.prettier},
    lua = {tools.luaFormat},
    json = {tools.prettier},
    yaml = {tools.prettier}
}

return languages
